//
//  DetailPopupViewModel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Combine
import Foundation

//class DetailPopupViewModel {
//
//    // MARK: - Input
//    struct Input {
//        var viewDidLoad: PassthroughSubject<Int, Never>
//        var pageDidChange: CurrentValueSubject<Int, Never>
//        let selectedURStringRange: PassthroughSubject<NSRange, Never>
//        var isImageDetail: Bool
//        let id: Int
//        let step: CarMakingStep
//    }
//
//    // MARK: - Output
//    struct Output {
//        var title = CurrentValueSubject<String, Never>("")
//        var subTitle = CurrentValueSubject<String, Never>("")
//        var description = CurrentValueSubject<URString, Never>(URString(fullText: ""))
//        var additionalInfo = CurrentValueSubject<[URString], Never>([])
//        var pageCount = CurrentValueSubject<Int, Never>(0)
//        var imageURL = CurrentValueSubject<String?, Never>(nil)
//        var selectedURStringRange = PassthroughSubject<NSRange, Never>()
//    }
//
//    // MARK: - Properties
//    private var cancellables = Set<AnyCancellable>()
//    private let usecase: DetailPopupUsecaseProtocol
//
//    // MARK: - Lifecycles
//    init(usecase: DetailPopupUsecaseProtocol = DetailPopupUsecase()) {
//        self.usecase = usecase
//    }
//
//    // MARK: - Helpers
//    func transform(_ input: Input) -> Output {
//        let output = Output()
//
//        input.viewDidLoad
//            .flatMap { [weak self] _ -> AnyPublisher<DetailOptionInfo, Never> in
//                guard let self = self else {
//                    return Just(MockDetailOptionEntity(title: "",
//                                                   description: "",
//                                                   info: nil,
//                                                   imageSrc: nil).toPresentation())
//                        .eraseToAnyPublisher()
//                }
//                return self.usecase.fetchAllDetails(step: input.step, id: input.id)
//                    .catch { error -> Just<DetailOptionInfo> in
//
//                        return Just(MockDetailOptionEntity(title: "Error",
//                                                       description: error.localizedDescription,
//                                                       info: nil,
//                                                       imageSrc: nil).toPresentation())
//                    }
//                    .eraseToAnyPublisher()
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { detailInfo in
//                output.pageCount.send(1)
//                output.title.send(detailInfo.title.fullText)
//                output.description.send(detailInfo.description)
//
//                let infoArray = detailInfo.info.map {
//                    URString(fullText: "\($0["title"] ?? ""), \($0["description"] ?? "")")
//                }
//                output.additionalInfo.send(infoArray)
//                output.imageURL.send(detailInfo.imageSrc)
//            })
//            .store(in: &cancellables)
//
//
//        input.pageDidChange
//            .flatMap { [weak self] page -> AnyPublisher<DetailOptionInfo, Never> in
//                guard let self = self else {
//                    return Just(MockDetailOptionEntity(title: "",
//                                                   description: "",
//                                                   info: nil,
//                                                   imageSrc: nil).toPresentation())
//                        .eraseToAnyPublisher()
//                }
//                return self.usecase.fetchDetailInfo(forPage: page)
//            }
//            .sink { detailInfo in
//                output.title.send(detailInfo.title.fullText)
//                output.description.send(detailInfo.description)
//                let infoArray = detailInfo.info.map {
//                    URString(fullText: "\($0["title"] ?? ""), \($0["description"] ?? "")")
//                }
//                output.additionalInfo.send(infoArray)
//                output.imageURL.send(detailInfo.imageSrc)
//            }
//            .store(in: &cancellables)
//
//        return output
//    }
//}


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
        var selectedURStringRange = PassthroughSubject<NSRange, Never>()
    }

    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let usecase: DetailPopupUsecaseProtocol

    // MARK: - Lifecycles
    init(usecase: DetailPopupUsecaseProtocol = DetailPopupUsecase()) {
        self.usecase = usecase
    }

    // MARK: - Helpers
    func transform(_ input: Input) -> Output {
        let output = Output()

        input.viewDidLoad
            .flatMap { [weak self] _ -> AnyPublisher<DetailOptionInfo, Never> in
                guard let self = self else {
                    return Just(MockDetailOptionEntity(title: "",
                                                   description: "",
                                                   info: nil,
                                                   imageSrc: nil).toPresentation())
                        .eraseToAnyPublisher()
                }
                return self.usecase.fetchAllDetails(step: input.step, id: input.id)
                    .catch { error -> Just<DetailOptionInfo> in
                        return Just(MockDetailOptionEntity(title: "Error",
                                                       description: error.localizedDescription,
                                                       info: nil,
                                                       imageSrc: nil).toPresentation())
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { detailInfo in
                output.pageCount.send(1)
                output.title.send(detailInfo.title.fullText)
                output.description.send(detailInfo.description)

                let infoArray = detailInfo.info.map {
                    URString(fullText: "\($0["title"] ?? ""), \($0["description"] ?? "")")
                }
                output.additionalInfo.send(infoArray)
                output.imageURL.send(detailInfo.imageSrc)
            })
            .store(in: &cancellables)

        input.pageDidChange
            .flatMap { [weak self] page -> AnyPublisher<[DetailOptionInfo], Never> in
                guard let self = self else {
                    let mockInfo = MockDetailOptionEntity(title: "",
                                                       description: "",
                                                       info: nil,
                                                       imageSrc: nil).toPresentation()
                    return Just([mockInfo]).eraseToAnyPublisher()
                }
                return self.usecase.fetchAllAdditionalOptions(id: input.id)
                    .catch { error -> Just<[DetailOptionInfo]> in
                        print("Error: \(error.localizedDescription)")
                        let mockInfo = MockDetailOptionEntity(title: "Error",
                                                           description: error.localizedDescription,
                                                           info: nil,
                                                           imageSrc: nil).toPresentation()
                        return Just([mockInfo])
                    }
                    .eraseToAnyPublisher()
            }
            .sink { detailInfos in
                guard let firstDetailInfo = detailInfos.first else { return }

                output.title.send(firstDetailInfo.title.fullText)
                output.description.send(firstDetailInfo.description)
                let infoArray = firstDetailInfo.info.map {
                    URString(fullText: "\($0["title"] ?? ""), \($0["description"] ?? "")")
                }
                output.additionalInfo.send(infoArray)
                output.imageURL.send(firstDetailInfo.imageSrc)

                output.pageCount.send(detailInfos.count) // Set the page count
            }
            .store(in: &cancellables)

        return output
    }
}
