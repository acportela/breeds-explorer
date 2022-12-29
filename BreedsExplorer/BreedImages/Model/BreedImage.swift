//
//  BreedImage.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

struct BreedImage: Identifiable, Hashable {

    var id = UUID()
    var name: String
    var imageURL: URL?

    init(name: String, imageURL: URL? = nil) {

        self.name = name
        self.imageURL = imageURL
    }
}
