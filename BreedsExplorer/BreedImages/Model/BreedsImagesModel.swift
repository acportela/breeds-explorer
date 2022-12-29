//
//  BreedsImagesModel.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

@MainActor
final class BreedsImagesModel: ObservableObject {

    @Published var images: [BreedImage]? {
        didSet {
            isFetching = false
        }
    }
    @Published var isFetching = false

    private let breedsProvider: BreedsImagesProviderProtocol

    init(breedsProvider: BreedsImagesProviderProtocol) {
        self.breedsProvider = breedsProvider
    }

    func fetchBreedsImages(page: UInt, order: ResultOrder) {

        self.isFetching = true

        Task {
            do {
                self.images = try await breedsProvider.loadBreedImages(page: page, order: order)
            } catch {
                throw error
            }
        }
    }
}
