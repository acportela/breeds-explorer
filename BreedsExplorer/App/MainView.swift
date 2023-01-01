//
//  MainView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct MainView: View {

    let imageProvider: BreedsImagesProviderProtocol
    let searchProvider: BreedsSearchProviderProtocol

    var body: some View {
        TabView {
            NavigationStack {
                GeometryReader { proxy in
                    BreedsImagesView(model: BreedsImagesModel(provider: imageProvider),
                                     availableWidth: proxy.size.width)
                }
            }.tabItem {
                Label(String.breeds, systemImage: .pawImage)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.breedsSecondaryColor, for: .tabBar)

            NavigationStack {
                BreedsSearchView(model: BreedsSearchModel(provider: searchProvider))
            }.tabItem {
                Label(String.search, systemImage: .searchImage)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.breedsSecondaryColor, for: .tabBar)
        }
        .tint(.breedsPrimaryColor)
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {

        // Switch do actual provider to see the actual images
        MainView(imageProvider: BreedsImagesProviderMock(),
                 searchProvider: BreedsSearchProviderMock())
    }
}
