//
//  BreedsImageList.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImageList: View {

    let breeds: [BreedImage]

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
            .listRowInsets(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
        }
        .listStyle(.plain)
        .foregroundColor(Color.breedsPrimaryColor)
        .navigationDestination(for: BreedImage.self) { breed in
            BreedDetail(breed: breed)
        }
    }
}

struct BreedsImageList_Previews: PreviewProvider {
    static var previews: some View {
        BreedsImageList(breeds: BreedsImagesProviderMock.testModel)
    }
}
