//
//  BreedsImagesModel.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

@MainActor
final class BreedsImagesModel: ObservableObject {

    @Published var images: [Breed]? {
        didSet {
            isFetching = false
        }
    }
    @Published var isFetching = false

    private let provider: BreedsImagesProviderProtocol

    init(provider: BreedsImagesProviderProtocol) {
        self.provider = provider
    }

    func fetchBreedsImages(page: UInt, sortOrder: ImagesSortOrder) {

        self.isFetching = true

        Task {
            do {
                self.images = try await provider.loadBreedImages(page: page, order: sortOrder.resultOrder)
            } catch {
                throw error
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
