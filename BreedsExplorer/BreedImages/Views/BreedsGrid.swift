//
//  BreedsGrid.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsGrid: View {

    let breeds: [BreedImage]

    var gridItems: [GridItem] { [GridItem(.adaptive(minimum: 72, maximum: 100), spacing: 24, alignment: .top)] }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 24) {
                ForEach(breeds) { breed in
                    NavigationLink(value: breed) {
                        VStack(spacing: 16.0) {
                            ImageAndTextView(breed: breed)
                        }
                    }
                }
            }
            .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
            .foregroundColor(Color.breedsPrimaryColor)
            .navigationDestination(for: BreedImage.self) { breed in
                BreedDetail(breed: breed)
            }
        }
    }
}

struct BreedsGrid_Previews: PreviewProvider {
    static var previews: some View {
        BreedsGrid(breeds: BreedsImagesProviderMock.testModel)
    }
}
