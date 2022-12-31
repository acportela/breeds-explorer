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

    @Binding var shouldRequestMoreItems: Bool

    var body: some View {

        List(breeds.enumerated().map { $0 }, id: \.element.id) { (index, breed) in
            HStack(spacing: 16) {
                ImageAndTextView(breed: breed)
            }
            .onAppear {
                let unshownItemsCount = self.breeds.count - (index + 1)
                if unshownItemsCount <= loadMoreThreshold {
                    shouldRequestMoreItems = true
                }
            }
            .frame(height: 70)
            .background(NavigationLink(value: breed) { }.opacity(0))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.breedsSecondaryColor)
            .listRowInsets(.init(top: 12, leading: 24, bottom: 12, trailing: 12))
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
                         shouldRequestMoreItems: $shouldRequestMoreItems)
    }
}
