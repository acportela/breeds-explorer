//
//  BreedsExplorerApp.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

@main
struct BreedsExplorerApp: App {

    @StateObject var breedsModel = BreedsModel()

    var body: some Scene {
        WindowGroup {
            MainView(model: breedsModel)
        }
    }
}

final class BreedsModel: ObservableObject {

    @Published var breedsImages: [BreedImageModel]?

    let defaultImagesQueryParameters = ["page": "0",
                                        "limit": "10",
                                        "size": "thumb",
                                        "mime_types": "jpg",
                                        "order": "RANDOM",
                                        "format": "json",
                                        "has_breeds": "true"]
    let apiFieldKey = "x-api-key"
    let apiKey = "live_9hSa9OVRDN1Ru2saSuMMxXJZbCuuYyvlbIVNVZqxI6uetQdK77bOGmLqx4WPQn2v"
    let httpMethod = "GET"
    let baseURL = "https://api.thecatapi.com/v1"
    let imagesPath = "/images/search"

    enum BreedsRequestError: Error {

        case invalidResponse
        case invalidContent
    }

    init() {}

    func fetchBreedsImages() async throws {

        var components = URLComponents(string: baseURL + imagesPath)
        components?.queryItems = self.defaultImagesQueryParameters.map { URLQueryItem(name: $0, value: $1) }

        guard let url = components?.url else {

            assertionFailure("Bad URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.setValue(self.apiKey, forHTTPHeaderField: apiFieldKey)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {

            throw BreedsRequestError.invalidResponse
        }

        guard let catImages = try? JSONDecoder().decode([CatImageDecodable].self, from: data) else {

            throw BreedsRequestError.invalidContent
        }

        let fetchedBreeds: [BreedImageModel] = catImages.map { BreedImageModel(name: $0.breed.name, imageURL: $0.url) }

        await MainActor.run {
            self.breedsImages = fetchedBreeds
       }
    }
}

struct BreedImageModel: Identifiable, Hashable {

    var id = UUID()
    var name: String
    var imageURL: URL?

    init(name: String, imageURL: URL? = nil) {
        self.name = name
        self.imageURL = imageURL
    }
}

extension BreedImageModel {

    static let testModel: [BreedImageModel] = [BreedImageModel(name: "Shih Tzu"),
                                               BreedImageModel(name: "Terrier"),
                                               BreedImageModel(name: "Poodle"),
                                               BreedImageModel(name: "German Shepard"),
                                               BreedImageModel(name: "Abyssinian"),
                                               BreedImageModel(name: "Snowshoe"),
                                               BreedImageModel(name: "Tonkinese"),
                                               BreedImageModel(name: "Turkish Angora")]
}
