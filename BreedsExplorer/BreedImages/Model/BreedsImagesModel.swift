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
    @Published var sortOrder: ImagesSortOrder = .random

    private (set) var currentPage: UInt = 0
    private static let fetchMoreThreshold = 10

    private let provider: BreedsImagesProviderProtocol

    init(provider: BreedsImagesProviderProtocol) {

        self.provider = provider
    }

    func reloadItems() {

        self.fetchContent(newPage: 0)
    }

    func fetchMoreContentIfNeeded(for breedId: Breed.ID) {

        let thresholdIndex = breeds.index(breeds.endIndex, offsetBy: -Self.fetchMoreThreshold)
        let shouldLoadMore = breeds.firstIndex(where: { $0.id == breedId }) == thresholdIndex

        if shouldLoadMore { self.fetchContent(newPage: self.currentPage + 1) }
    }
}

private extension BreedsImagesModel {

    func fetchContent(newPage: UInt) {

        self.isFetching = true

        Task {
            do {

                let newContent = try await provider.loadBreedImages(page: newPage, order: sortOrder.resultOrder)
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
