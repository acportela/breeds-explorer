//
//  BreedsImageList.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImageList: View {

    let breeds: [Breed]

    var body: some View {

        List {
            ForEach(breeds) { breed in
                HStack(spacing: 16.0) {
                    Image(systemName: breed.image)
                        .resizable()
                        .scaledToFit()
                    Text(breed.name)
                        .font(.title2)

                }
                .background(NavigationLink(value: breed) { }.opacity(0))
                .frame(height: 60)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.breedsSecondaryColor)
            }
        }
        .listStyle(.plain)
        .foregroundColor(Color.breedsPrimaryColor)
        .navigationDestination(for: Breed.self) { breed in
            BreedDetail(breed: breed)
        }
    }
}

struct BreedsImageList_Previews: PreviewProvider {
    static var previews: some View {
        BreedsImageList(breeds: BreedsModel().breeds)
    }
}
