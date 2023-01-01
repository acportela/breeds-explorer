//
//  BreedsGrid.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsGrid: View {

    @ObservedObject var model: BreedsImagesModel
    let hasLargeWidth: Bool

    private var largeGridItem: GridItem { GridItem(.adaptive(minimum: 144, maximum: 288),
                                                   spacing: 96,
                                                   alignment: .top) }
    private var regularGridItem: GridItem { GridItem(.adaptive(minimum: 72, maximum: 96),
                                                     spacing: 36,
                                                     alignment: .top) }
    private var gridItems: [GridItem] { hasLargeWidth ?  [largeGridItem] : [regularGridItem] }

    private var horizontalSpacing: CGFloat { hasLargeWidth ? 48 : 24 }
    private var verticalSpacing: CGFloat { hasLargeWidth ? 16 : 8 }
    private var imageSize: CGFloat { hasLargeWidth ? 200 : 100 }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 24) {
                ForEach(model.breeds) { breed in
                    NavigationLink(value: breed) {
                        VStack(spacing: 16.0) {
                            ImageAndTextView(breed: breed, imageSize: imageSize).font(.headline)
                        }
                        .animation(.default, value: breed.id)
                        .onAppear {
                            model.fetchMoreContentIfNeeded(for: breed.id)
                        }
                    }
                }
            }
            .padding(.init(top: verticalSpacing,
                           leading: horizontalSpacing,
                           bottom: verticalSpacing,
                           trailing: horizontalSpacing))
            .foregroundColor(Color.breedsPrimaryColor)
            .navigationDestination(for: Breed.self) { breed in
                BreedDetail(breed: breed)
            }
        }
    }
}

struct BreedsGrid_Previews: PreviewProvider {

    static var previews: some View {
        BreedsGrid(model: BreedsImagesModel(provider: BreedsImagesProviderMock()),
                   hasLargeWidth: false)
    }
}
