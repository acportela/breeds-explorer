//
//  BreedsImagesExplorer.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesExplorer: View {

    @ObservedObject var model: BreedsImagesModel

    @State private var layoutConfiguration = LayoutConfiguration.grid
    @State private var sortOrder = ImagesSortOrder.random

    var body: some View {

        LoadingView(isLoading: model.isFetching) {
            ZStack {
                switch layoutConfiguration {
                case .grid:
                    BreedsGrid(breeds: model.images ?? [])
                case .list:
                    BreedsImageList(breeds: model.images ?? [])
                }
            }
            .onAppear {
                if model.images == nil {
                    self.loadContent()
                }
            }
            .refreshable {
                self.loadContent()
            }
            .toolbar {
                ToolbarItem {
                    toolbarItem
                }
            }
            .background(Color.breedsSecondaryColor)
            .navigationTitle(String.breeds)
        }
    }

    @ViewBuilder
    var toolbarItem: some View {
        Menu {
            Picker("Layout Configuration", selection: $layoutConfiguration) {
                ForEach(LayoutConfiguration.allCases) { config in
                    Label(config.title, systemImage: config.icon).tag(config)
                }
            }
            .pickerStyle(.inline)
            Picker("Sort Order", selection: $sortOrder) {
                ForEach(ImagesSortOrder.allCases) { sort in
                    Label(sort.title, systemImage: sort.icon).tag(sort)
                }
            }
            .pickerStyle(.inline)
            .onChange(of: sortOrder) { _ in
                self.loadContent()
            }
        } label: {
            Label("", systemImage: .gearImage).labelStyle(.iconOnly)
        }
    }
}

private extension BreedsImagesExplorer {

    enum LayoutConfiguration: String, CaseIterable, Identifiable {

        case grid, list

        var id: String { self.rawValue }

        var title: String {
            switch self {
            case .grid: return .grid
            case .list: return .list
            }
        }

        var icon: String {
            switch self {
            case .grid: return .gridIcon
            case .list: return .listIcon
            }
        }
    }

    func loadContent() {
        self.model.fetchBreedsImages(page: 0, sortOrder: sortOrder)
    }
}

enum ImagesSortOrder: String, CaseIterable, Identifiable {

    case alphabetical, random

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .alphabetical: return .sortAZ
        case .random: return .sortRandom
        }
    }

    var icon: String {
        switch self {
        case .alphabetical: return .sortAZImage
        case .random: return .sortRandomImage
        }
    }
}

struct BreedsImagesExplorer_Previews: PreviewProvider {

    static var previews: some View {
        BreedsImagesExplorer(model: BreedsImagesModel(breedsProvider: BreedsImagesProviderMock()))
    }
}
