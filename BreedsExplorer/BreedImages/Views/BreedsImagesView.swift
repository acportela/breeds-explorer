//
//  BreedsImagesView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesView: View {

    @StateObject var model: BreedsImagesModel
    @State private var layoutConfiguration = LayoutConfiguration.grid
    @State private var sortOrder = ImagesSortOrder.random

    var body: some View {

        LoadingView(isLoading: model.isFetching && model.breeds.isEmpty) {
            ZStack {
                switch layoutConfiguration {
                case .grid:
                    BreedsGrid(breeds: model.breeds)
                case .list:
                    BreedsImagesList(breeds: model.breeds)
                }
            }
            .opacity(model.isFetching ? 0.5 : 1)
            .disabled(model.isFetching ? true : false)
            .onAppear {
                if model.breeds.isEmpty {
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

private extension BreedsImagesView {

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

private extension String {

    static let gridIcon = "square.grid.2x2"
    static let listIcon = "list.bullet"
    static let sortAZImage = "textformat.abc"
    static let sortRandomImage = "shuffle"
    static let gearImage = "gear"

    static let grid = "Grid"
    static let list = "List"

    static let sortAZ = "A-Z"
    static let sortRandom = "Random"
}

struct BreedsImagesExplorer_Previews: PreviewProvider {

    static let model = BreedsImagesModel(provider: BreedsImagesProviderMock())

    static var previews: some View {
        BreedsImagesView(model: model)
    }
}
