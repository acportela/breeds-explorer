//
//  BreedsSearchProviderMock.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import Foundation

struct BreedsSearchProviderMock: BreedsSearchProviderProtocol {

    func fetchAllBreeds() async throws -> [Breed] {

        return BreedsImagesProviderMock.testModel
    }
}

extension BreedsSearchProviderMock {

    static let description = "York Chocolate cats are known to be true lap cats with a sweet temperament"

    static let testModel: [Breed] = [Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15"),
                                     Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15"),
                                     Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15"),
                                     Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15"),
                                     Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15"),
                                     Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15"),
                                     Breed(name: "York Chocolate",
                                           imageURL: nil,
                                           description: description,
                                           origin: "United States",
                                           temperament: "Playful, Social, Intelligent, Curious, Friendly",
                                           lifeSpan: "13 - 15")]
}
