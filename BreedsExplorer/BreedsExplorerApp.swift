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

    @Published var breeds: [Breed] = []

    init() {

        // TODO - Remove it. Mocking purposes only
        self.breeds = [Breed(name: "Shih Tzu", image: .pawImage),
                       Breed(name: "Terrier", image: .searchImage),
                       Breed(name: "Poodle", image: .pawImage),
                       Breed(name: "German Shepard", image: .searchImage)]
    }
}

struct Breed: Identifiable, Hashable {

    var id = UUID()

    var name: String
    // TODO - change to URL
    var image: String
}
