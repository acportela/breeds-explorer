//
//  MainView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct MainView: View {

    @ObservedObject var model: BreedsModel

    var body: some View {
        TabView {
            NavigationStack {
                BreedsImagesExplorer(model: model)
            }.tabItem {
                Label(String.breeds, systemImage: .pawImage)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.breedsSecondaryColor, for: .tabBar)

            NavigationStack {
                SearchBreeds()
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
        MainView(model: BreedsModel())
    }
}
