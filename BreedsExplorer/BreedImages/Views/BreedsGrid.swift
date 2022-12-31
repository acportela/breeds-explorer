//
//  BreedsGrid.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsGrid: View {

    let breeds: [Breed]
    let loadMoreThreshold: Int

    @Binding var shouldRequestMoreItems: Bool

    var gridItems: [GridItem] { [GridItem(.adaptive(minimum: 72, maximum: 100), spacing: 24, alignment: .top)] }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 24) {
                ForEach(breeds.enumerated().map { $0 }, id: \.element) { index, breed in
                    NavigationLink(value: breed) {
                        VStack(spacing: 16.0) {
                            ImageAndTextView(breed: breed)
                        }
                        .animation(.default, value: breed.id)
                        .onAppear {
                            let unshownItemsCount = self.breeds.count - (index + 1)
                            if unshownItemsCount <= loadMoreThreshold {
                                shouldRequestMoreItems = true
                            }
                        }
                    }
                }
            }
            .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
            .foregroundColor(Color.breedsPrimaryColor)
            .navigationDestination(for: Breed.self) { breed in
                BreedDetail(breed: breed)
            }
        }
    }
}

struct BreedsGrid_Previews: PreviewProvider {

    @State static var shouldRequestMoreItems = false

    static var previews: some View {
        BreedsGrid(breeds: BreedsImagesProviderMock.testModel,
                   loadMoreThreshold: 10,
                   shouldRequestMoreItems: $shouldRequestMoreItems)
    }
}
