//
//  CatImageDecodable.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

struct CatImageDecodable: Decodable {

    let breed: BreedInformation
    let id: String
    let url: URL

    enum CodingKeys: String, CodingKey {

        case breeds
        case id
        case url
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)

        let urlString = try container.decode(String.self, forKey: .url)
        let breeds = try container.decode([BreedInformation].self, forKey: .breeds)

        guard let breed = breeds.first, let url = URL(string: urlString) else {

            let description = String(describing: type(of: Self.self))
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: description)
            throw DecodingError.valueNotFound(Self.self, context)
        }

        self.breed = breed
        self.url = url
    }
}

struct BreedInformation: Decodable {

    let name: String
    let temperament: String?
    let origin: String?
    let description: String?
    let lifeSpan: String?

    enum CodingKeys: String, CodingKey {

        case name
        case temperament
        case origin
        case description
        case lifeSpan = "life_span"
    }
}
