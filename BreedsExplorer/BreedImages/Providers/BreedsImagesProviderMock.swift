//
//  BreedsImagesProviderMock.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

struct BreedsImagesProviderMock: BreedsImagesProviderProtocol {

    func loadBreedImages(page: UInt, order: ResultOrder) async throws -> [BreedImage] {

        return [BreedImage(name: "Shih Tzu"),
                BreedImage(name: "Terrier"),
                BreedImage(name: "Poodle"),
                BreedImage(name: "German Shepard"),
                BreedImage(name: "Abyssinian"),
                BreedImage(name: "Snowshoe"),
                BreedImage(name: "Tonkinese"),
                BreedImage(name: "Turkish Angora")]
    }
}

extension BreedsImagesProviderMock {

    static let testModel: [BreedImage] = [BreedImage(name: "Shih Tzu"),
                                               BreedImage(name: "Terrier"),
                                               BreedImage(name: "Poodle"),
                                               BreedImage(name: "German Shepard"),
                                               BreedImage(name: "Abyssinian"),
                                               BreedImage(name: "Snowshoe"),
                                               BreedImage(name: "Tonkinese"),
                                               BreedImage(name: "Turkish Angora")]
}
