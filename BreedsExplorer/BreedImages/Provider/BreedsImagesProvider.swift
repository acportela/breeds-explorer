//
//  BreedsImagesProvider.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

private extension String {

    static let pageKey = "page"
    static let orderKey = "order"
    static let limitKey = "limit"
    static let sizeKey = "size"
    static let imageTypeKey = "mime_types"
    static let formatKey = "format"
    static let hasBreedsKey = "has_breeds"
    static let apiFieldKey = "x-api-key"
    // TODO - Remove it or use cocoa keys
    static let apiKey = "live_9hSa9OVRDN1Ru2saSuMMxXJZbCuuYyvlbIVNVZqxI6uetQdK77bOGmLqx4WPQn2v"
    static let httpMethod = "GET"
    static let baseURL = "https://api.thecatapi.com/v1"
    static let imagesPath = "/images/search"
}

enum ResultOrder: String {
    case ascending = "ASC"
    case random = "RANDOM"
}

enum BreedsRequestError: Error {

    case invalidResponse
    case invalidContent
}

protocol BreedsImagesProviderProtocol {

    func loadBreedImages(page: UInt, order: ResultOrder) async throws -> [Breed]
}

struct BreedsImagesProvider: BreedsImagesProviderProtocol {

    private let urlSession = URLSession.shared

    let imagesQueryParameters: [String: String] = [.pageKey: "0",
                                                   .limitKey: "10",
                                                   .sizeKey: "thumb",
                                                   .imageTypeKey: "jpg",
                                                   .orderKey: "RANDOM",
                                                   .formatKey: "json",
                                                   .hasBreedsKey: "true"]

    func loadBreedImages(page: UInt = 0, order: ResultOrder = .random) async throws -> [Breed] {

        guard let request = self.makeRequestWith(page: page, order: order) else { return [] }

        let (data, response) = try await urlSession.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BreedsRequestError.invalidResponse
        }

        do {

            let breedsImages = try JSONDecoder().decode([BreedImagesDecodable].self, from: data)
            return breedsImages.map { item in
                Breed(name: item.breedInfo.name,
                      imageURL: item.url,
                      description: item.breedInfo.description,
                      origin: item.breedInfo.origin,
                      temperament: item.breedInfo.temperament,
                      lifeSpan: item.breedInfo.lifeSpan)
            }

        } catch {
            throw error
        }
    }
}

private extension BreedsImagesProvider {

    func makeRequestWith(page: UInt = 0, order: ResultOrder = .random) -> URLRequest? {

        var queryParameters = imagesQueryParameters
        queryParameters[.pageKey] = String(page)
        queryParameters[.orderKey] = String(order.rawValue)

        var components = URLComponents(string: .baseURL + .imagesPath)
        components?.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }

        guard let url = components?.url else {
            assertionFailure("Bad URL")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = .httpMethod
        request.setValue(.apiKey, forHTTPHeaderField: .apiFieldKey)

        return request
    }
}
