//
//  BreedDetail.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedDetail: View {

    private var traits: [ListTrait]
    private let imageUrl: URL?
    private let navigationTitle: String

    init(breed: Breed) {

        self.imageUrl = breed.imageURL
        self.navigationTitle = breed.name

        let models = [ListTrait(traitName: .name, traitValue: breed.name),
                      ListTrait(traitName: .origin, traitValue: breed.origin),
                      ListTrait(traitName: .description, traitValue: breed.description),
                      ListTrait(traitName: .temperament, traitValue: breed.temperament),
                      ListTrait(traitName: .lifeSpan, traitValue: breed.lifeSpan)]

        self.traits = models.compactMap { $0 }
    }

    var body: some View {
        List {
            Section {
                ForEach(traits) { item in
                    BreedDetailItem(trait: item)
                }
                .listRowInsets(.init(top: 16, leading: 24, bottom: 16, trailing: 24))
            } header: {
                BreedDetailHeader(imageUrl: imageUrl)
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ListTrait: Identifiable {

    let id = UUID()
    let traitName: String
    let traitValue: String

    init?(traitName: String, traitValue: String?) {
        self.traitName = traitName
        guard let traitValue = traitValue else { return nil }
        self.traitValue = traitValue
    }
}

private extension String {

    static let name = "Name"
    static let origin = "Origin"
    static let lifeSpan = "Life Span"
    static let temperament = "Temperament"
    static let description = "Description"
}

struct BreedDetail_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetail(breed: BreedsImagesProviderMock.testModel[0])
    }
}
