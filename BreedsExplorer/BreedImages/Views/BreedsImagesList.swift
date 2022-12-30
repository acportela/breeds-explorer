//
//  BreedsImagesList.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesList: View {

    let breeds: [Breed]

    var body: some View {

        List {
            ForEach(breeds) { breed in
                HStack(spacing: 16) {
                    ImageAndTextView(breed: breed)
                }
                .frame(height: 70)
                .background(NavigationLink(value: breed) { }.opacity(0))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.breedsSecondaryColor)
            }
            .listRowInsets(.init(top: 12, leading: 24, bottom: 12, trailing: 12))
        }
        .foregroundColor(Color.breedsPrimaryColor)
        .navigationDestination(for: Breed.self) { breed in
            BreedDetail(breed: breed)
        }
    }
}

struct BreedsImageList_Previews: PreviewProvider {
    static var previews: some View {
        BreedsImagesList(breeds: BreedsImagesProviderMock.testModel)
    }
}
