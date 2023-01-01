//
//  BreedsImagesList.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesList: View {

    let breeds: [Breed]
    let loadMoreThreshold: Int
    let hasLargeWidth: Bool

    var size: CGFloat { hasLargeWidth ? 200 : 100 }
    var spacing: CGFloat { hasLargeWidth ? 48 : 24 }

    @Binding var shouldRequestMoreItems: Bool

    var body: some View {

        List(breeds.enumerated().map { $0 }, id: \.element.id) { (index, breed) in
            HStack(spacing: 16) {
                ImageAndTextView(breed: breed, imageSize: size)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .onAppear {
                let unshownItemsCount = self.breeds.count - (index + 1)
                if unshownItemsCount <= loadMoreThreshold {
                    shouldRequestMoreItems = true
                }
            }
            .frame(height: size)
            .background(NavigationLink(value: breed) { }.opacity(0))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.breedsSecondaryColor)
            .listRowInsets(.init(top: spacing, leading: spacing, bottom: 12, trailing: 12))
            .animation(.default, value: index)
        }
        .foregroundColor(Color.breedsPrimaryColor)
        .navigationDestination(for: Breed.self) { breed in
            BreedDetail(breed: breed)
        }
    }
}

struct BreedsImageList_Previews: PreviewProvider {

    @State static var shouldRequestMoreItems = false

    static var previews: some View {
        BreedsImagesList(breeds: BreedsImagesProviderMock.testModel,
                         loadMoreThreshold: 10,
                         hasLargeWidth: false,
                         shouldRequestMoreItems: $shouldRequestMoreItems)
    }
}
