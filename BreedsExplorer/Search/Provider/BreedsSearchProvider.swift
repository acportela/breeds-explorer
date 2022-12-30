//
//  BreedsSearchProvider.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import Foundation

private extension String {

    static let apiFieldKey = "x-api-key"
    // TODO - Remove it or use cocoa keys
    static let apiKey = "live_9hSa9OVRDN1Ru2saSuMMxXJZbCuuYyvlbIVNVZqxI6uetQdK77bOGmLqx4WPQn2v"
    static let httpMethod = "GET"
    static let baseURL = "https://api.thecatapi.com/v1/breeds"
}

protocol BreedsSearchProviderProtocol {

    func fetchAllBreeds() async throws -> [Breed]
}

struct BreedsSearchProvider: BreedsSearchProviderProtocol {

    private let urlSession = URLSession.shared

    func fetchAllBreeds() async throws -> [Breed] {

        guard let request = self.makeURLRequest() else { return [] }

        let (data, response) = try await urlSession.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BreedsRequestError.invalidResponse
        }

        do {
            let decoded = try JSONDecoder().decode([BreedsSearchDecodable].self, from: data)
            return decoded.map { breedInfo in
                Breed(name: breedInfo.name,
                      imageURL: breedInfo.imageURL,
                      description: breedInfo.description,
                      origin: breedInfo.origin,
                      temperament: breedInfo.temperament,
                      lifeSpan: breedInfo.lifeSpan)
            }

        } catch {
            throw error
        }
    }
}

private extension BreedsSearchProvider {

    func makeURLRequest() -> URLRequest? {

        guard let url = URL(string: .baseURL) else {
            assertionFailure("Bad URL")
            return nil
        }

        var request = URLRequest(url: url, timeoutInterval: 30.0)
        request.httpMethod = .httpMethod
        request.setValue(.apiKey, forHTTPHeaderField: .apiFieldKey)

        return request
    }
}
