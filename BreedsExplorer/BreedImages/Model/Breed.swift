//
//  Breed.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import Foundation

struct Breed: Identifiable, Hashable {

    let id = UUID()
    let name: String
    let imageURL: URL?
    let description: String?
    let origin: String?
    let temperament: String?
    let lifeSpan: String?

    init(name: String,
         imageURL: URL?,
         description: String?,
         origin: String?,
         temperament: String?,
         lifeSpan: String?) {

        self.name = name
        self.imageURL = imageURL
        self.description = description
        self.origin = origin
        self.temperament = temperament
        self.lifeSpan = lifeSpan
    }
}
