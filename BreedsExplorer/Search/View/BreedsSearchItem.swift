//
//  BreedsSearchItem.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import SwiftUI

struct BreedsSearchItem: View {

    let breed: Breed

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(breed.name)
                .font(.headline)
            Text(breed.origin ?? "")
                .foregroundColor(.breedsPrimaryColor)
                .font(.body)
            Text(breed.temperament ?? "")
                .foregroundColor(.breedsPrimaryColor)
                .font(.body)
        }
        .background(NavigationLink(value: breed) { }.opacity(0))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.breedsSecondaryColor)
    }
}

struct BreedsSearchItem_Previews: PreviewProvider {
    static var previews: some View {
        BreedsSearchItem(breed: BreedsSearchProviderMock.testModel[0])
    }
}
