//
//  BreedsSearchDecodable.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import Foundation

struct BreedsSearchDecodable: Decodable {

    let name: String
    let temperament: String?
    let origin: String?
    let description: String?
    let lifeSpan: String?
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {

        case name
        case temperament
        case origin
        case description
        case lifeSpan = "life_span"
        case image
    }

    enum ImageKeys: String, CodingKey {

        case url
    }

    init(from decoder: Decoder) throws {

        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.temperament = try container.decodeIfPresent(String.self, forKey: .temperament)
            self.origin = try container.decodeIfPresent(String.self, forKey: .origin)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.lifeSpan = try container.decodeIfPresent(String.self, forKey: .lifeSpan)

            guard let imageContainer = try? container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image) else {
                self.imageURL = nil
                return
            }

            let url = try imageContainer.decodeIfPresent(String.self, forKey: .url) ?? ""
            self.imageURL = URL(string: url)

        } catch {
            throw BreedsRequestError.invalidContent
        }
    }
}
