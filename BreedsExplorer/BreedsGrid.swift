//
//  BreedsGrid.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsGrid: View {

    let breeds: [Breed]

    var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 60), spacing: 24, alignment: .top)]
    }

    var body: some View {

        LazyVGrid(columns: gridItems, spacing: 16) {
            ForEach(breeds) { breed in
                NavigationLink(value: breed) {
                    VStack(spacing: 12.0) {
                        Image(systemName: breed.image)
                            .resizable()
                            .scaledToFit()
                        Text(breed.name)
                            .font(.subheadline)
                    }

                }
            }
        }
        .foregroundColor(Color.breedsPrimaryColor)
        .padding()
        .navigationDestination(for: Breed.self) { breed in
            BreedDetail(breed: breed)
        }
    }
}

struct BreedsGrid_Previews: PreviewProvider {
    static var previews: some View {
        BreedsGrid(breeds: BreedsModel().breeds)
    }
}
