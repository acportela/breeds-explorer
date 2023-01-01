//
//  BreedsImagesModel.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

@MainActor
final class BreedsImagesModel: ObservableObject {

    @Published private (set) var breeds: [Breed] = [] {

        didSet { isFetching = false }
    }

    @Published private (set) var isFetching = false
    private (set) var currentPage: UInt = 0

    private let provider: BreedsImagesProviderProtocol

    init(provider: BreedsImagesProviderProtocol) {

        self.provider = provider
    }

    func reloadItems(sortOrder: ImagesSortOrder) {

        self.fetchContent(newPage: 0, order: sortOrder)
    }

    func fetchNextPage(sortOrder: ImagesSortOrder) {

        self.fetchContent(newPage: self.currentPage + 1, order: sortOrder)
    }
}

private extension BreedsImagesModel {

    func fetchContent(newPage: UInt, order: ImagesSortOrder) {

        self.isFetching = true

        Task {
            do {

                let newContent = try await provider.loadBreedImages(page: newPage, order: order.resultOrder)
                self.breeds = newPage == 0 ? newContent : breeds + newContent

                if newContent.isEmpty == false {

                    currentPage = newPage
                }

            } catch {

                self.breeds = []
                self.currentPage = 0
            }
        }
    }
}

private extension ImagesSortOrder {

    var resultOrder: ResultOrder {

        switch self {

        case .alphabetical:
            return .ascending
        case .random:
            return .random
        }
    }
}
