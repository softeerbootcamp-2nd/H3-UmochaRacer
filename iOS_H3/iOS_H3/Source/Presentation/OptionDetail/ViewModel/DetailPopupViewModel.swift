//
//  DetailPopupViewModel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Combine
import Foundation

final class DetailPopupViewModel {

    // MARK: - Input
    struct Input {
        var viewDidLoad: PassthroughSubject<Void, Never>
        var pageDidChange: CurrentValueSubject<Int, Never>
        var isImageDetail: Bool
    }

    // MARK: - Output
    struct Output {
        var title = CurrentValueSubject<String, Never>("")
        var subTitle = CurrentValueSubject<String, Never>("")
        var description = CurrentValueSubject<String, Never>("")
        var additionalInfo = CurrentValueSubject<String, Never>("")
        var pageCount = CurrentValueSubject<Int, Never>(0)
        var imageURL = CurrentValueSubject<URL?, Never>(nil)
    }

    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let usecase: DetailPopupUsecaseProtocol

    // MARK: - Lifecycles
    init(usecase: DetailPopupUsecaseProtocol = MockDetailPopupUsecase()) {
        self.usecase = usecase
    }

    // MARK: - Helpers
    func transform(_ input: Input) -> Output {
        let output = Output()

        input.viewDidLoad
            .flatMap { [weak self] in
                guard let self = self else {
                    return Just(DetailInfo(title: "", subTitle: "", description: "", additionalInfo: "", imageURL: nil))
                        .eraseToAnyPublisher()
                }
                return self.usecase.fetchDetailInfo(forPage: 0)
            }
            .sink { detailInfo in
                output.title.send(detailInfo.title)
                output.subTitle.send(detailInfo.subTitle)
                output.description.send(detailInfo.description)
                output.additionalInfo.send(detailInfo.additionalInfo)
                output.imageURL.send(detailInfo.imageURL)
                output.pageCount.send(3)    // 임시 페이지
                print("\(detailInfo.title) 페이지")
            }
            .store(in: &cancellables)

        input.pageDidChange
            .flatMap { [weak self] page -> AnyPublisher<DetailInfo, Never> in
                guard let self = self else {
                    return Just(DetailInfo(title: "", subTitle: "", description: "", additionalInfo: "", imageURL: nil))
                        .eraseToAnyPublisher()
                }
                return self.usecase.fetchDetailInfo(forPage: page)
            }
            .sink { detailInfo in
                output.title.send(detailInfo.title)
                output.subTitle.send(detailInfo.subTitle)
                output.description.send(detailInfo.description)
                output.additionalInfo.send(detailInfo.additionalInfo)
                output.imageURL.send(detailInfo.imageURL)
                print("\(detailInfo.title) 페이지")
            }
            .store(in: &cancellables)

        return output
    }
}
