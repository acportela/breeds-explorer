//
//  BreedsImagesList.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesList: View {

    @ObservedObject var model: BreedsImagesModel
    let hasLargeWidth: Bool

    var size: CGFloat { hasLargeWidth ? 200 : 100 }
    var spacing: CGFloat { hasLargeWidth ? 48 : 24 }

    var body: some View {

        List(model.breeds) { breed in
            HStack(spacing: 16) {
                ImageAndTextView(breed: breed, imageSize: size)
                    .font(.title2)
                    .fontWeight(.bold)
                    .onAppear {
                        model.fetchMoreContentIfNeeded(for: breed.id)
                    }
            }
            .frame(height: size)
            .background(NavigationLink(value: breed) { }.opacity(0))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.breedsSecondaryColor)
            .listRowInsets(.init(top: self.spacing, leading: self.spacing, bottom: 12, trailing: 12))
            .animation(.default, value: breed.id)
        }
        .foregroundColor(Color.breedsPrimaryColor)
        .navigationDestination(for: Breed.self) { breed in
            BreedDetail(breed: breed)
        }
    }
}

struct BreedsImageList_Previews: PreviewProvider {

    static var previews: some View {
        BreedsImagesList(model: BreedsImagesModel(provider: BreedsImagesProviderMock()),
                         hasLargeWidth: false)
    }
}
