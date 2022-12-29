//
//  BreedsExplorerApp.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

@main
struct BreedsExplorerApp: App {

    @StateObject var imagesModel = BreedsImagesModel(breedsProvider: BreedsImagesProvider())

    var body: some Scene {
        WindowGroup {
            MainView(imagesModel: imagesModel)
        }
    }
}
