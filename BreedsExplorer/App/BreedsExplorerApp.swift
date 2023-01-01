//
//  BreedsExplorerApp.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

@main
struct BreedsExplorerApp: App {

    init() {

        URLCache.shared.memoryCapacity = 100_000_000
        URLCache.shared.diskCapacity = 1_000_000_000
    }

    var body: some Scene {
        WindowGroup {
            MainView(imageProvider: BreedsImagesProvider(), searchProvider: BreedsSearchProvider())
        }
    }
}
