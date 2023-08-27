//
//  DetailPopupViewModel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Combine
import Foundation

enum DetailError: Error {
    case invalidPageIndex
    case fetchingFailed
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidPageIndex:
            return "잘못된 페이지 접근입니다."
        case .fetchingFailed:
            return "자세히보기 정보 조회에 실패하였습니다."
        case .unknown:
            return "알 수 없는 에러가 발생하였습니다."
        }
    }
}

class DetailPopupViewModel {

    // MARK: - Input
    struct Input {
        var viewDidLoad: PassthroughSubject<Int, Never>
        var pageDidChange: CurrentValueSubject<Int, Never>
        let selectedURStringRange: PassthroughSubject<NSRange, Never>
        var isImageDetail: Bool
        let id: Int
        let step: CarMakingStep
    }

    // MARK: - Output
    struct Output {
        var title = CurrentValueSubject<String, Never>("")
        var subTitle = CurrentValueSubject<String, Never>("")
        var description = CurrentValueSubject<URString, Never>(URString(fullText: ""))
        var additionalInfo = CurrentValueSubject<[URString], Never>([])
        var pageCount = CurrentValueSubject<Int, Never>(0)
        var imageURL = CurrentValueSubject<String?, Never>(nil)
        var error = CurrentValueSubject<DetailError?, Never>(nil)
    }

    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let usecase: DetailPopupUsecaseProtocol
    private var currentDetails: [DetailOptionInfo] = []

    // MARK: - Lifecycles
    init(usecase: DetailPopupUsecaseProtocol = DetailPopupUsecase()) {
        self.usecase = usecase
    }

    // MARK: - Helpers
    func transform(_ input: Input) -> Output {
        let output = Output()

        handleViewDidLoad(input, output)
        handlePageChange(input, output)
        return output
    }

    private func handlePageChange(_ input: Input, _ output: Output) {
        input.pageDidChange
            .sink { [weak self] pageIndex in
                guard let self = self else { return }
                guard pageIndex >= 0 && pageIndex < self.currentDetails.count else {
                    output.error.send(.invalidPageIndex)
                    return
                }

                let detailInfo = self.currentDetails[pageIndex]
                self.populateOutput(output, with: detailInfo)
            }
            .store(in: &cancellables)
    }

    private func fetchDetails(for input: Input) -> AnyPublisher<[DetailOptionInfo], DetailError> {
        if input.step == .optionSelection {
            return usecase.fetchAllAdditionalOptions(id: input.id)
                .catch { error -> AnyPublisher<[DetailOptionInfo], DetailError> in
                    return Fail(outputType: [DetailOptionInfo].self, failure: .fetchingFailed).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        } else {
            return usecase.fetchAllDetails(step: input.step, id: input.id)
                .map { [$0] }
                .catch { error -> AnyPublisher<[DetailOptionInfo], DetailError> in
                    return Fail(outputType: [DetailOptionInfo].self, failure: .fetchingFailed).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }

    private func handleViewDidLoad(_ input: Input, _ output: Output) {
        input.viewDidLoad
            .flatMap { [weak self] _ -> AnyPublisher<[DetailOptionInfo], DetailError> in
                self?.fetchDetails(for: input) ?? Fail(outputType: [DetailOptionInfo].self,
                                                       failure: .unknown).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    output.error.send(error)
                }
            }, receiveValue: { [weak self] details in
                self?.currentDetails = details
                output.pageCount.send(details.count)
                guard let firstDetail = details.first else { return }
                self?.populateOutput(output, with: firstDetail)
            })
            .store(in: &cancellables)
    }

    private func populateOutput(_ output: Output, with detail: DetailOptionInfo) {
        output.title.send(detail.title.fullText)
        output.description.send(detail.description)
        let infoArray = detail.info.map {
            URString(fullText: "\($0["title"] ?? ""), \($0["description"] ?? "")")
        }
        output.additionalInfo.send(infoArray)
        output.imageURL.send(detail.imageSrc)
    }
}
