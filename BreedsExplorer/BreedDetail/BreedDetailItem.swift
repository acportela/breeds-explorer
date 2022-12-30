//
//  BreedDetailItem.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import SwiftUI

struct BreedDetailItem: View {

    let trait: ListTrait

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(trait.traitName)
                .font(.title2)
            Text(trait.traitValue)
                .foregroundColor(.breedsPrimaryColor)
                .font(.body)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.breedsSecondaryColor)
    }
}

struct BreedDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailItem(trait: ListTrait(traitName: "Name", traitValue: "Siamese")!)
    }
}
