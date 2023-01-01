//
//  BreedsImagesView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesView: View {

    static let loadMoreThreshold = 10

    @StateObject var model: BreedsImagesModel

    @State private var layoutConfiguration = LayoutConfiguration.grid
    @State private var sortOrder = ImagesSortOrder.random
    @State var shouldRequestMoreItems = false

    let availableWidth: CGFloat
    var hasLargeWidth: Bool { availableWidth > 430 }

    var body: some View {

        LoadingView(isLoading: model.isFetching) {
            ZStack {
                switch layoutConfiguration {
                case .grid:
                    BreedsGrid(breeds: model.breeds,
                               loadMoreThreshold: Self.loadMoreThreshold,
                               hasLargeWidth: hasLargeWidth,
                               shouldRequestMoreItems: $shouldRequestMoreItems)
                case .list:
                    BreedsImagesList(breeds: model.breeds,
                                     loadMoreThreshold: Self.loadMoreThreshold,
                                     hasLargeWidth: hasLargeWidth,
                                     shouldRequestMoreItems: $shouldRequestMoreItems)
                }
            }
            .onAppear {
                if model.breeds.isEmpty { self.model.reloadItems(sortOrder: sortOrder) }
            }
            .onChange(of: shouldRequestMoreItems) { newValue in
                if newValue == true { self.model.fetchNextPage(sortOrder: sortOrder) }
            }
            .onChange(of: model.currentPage) { _ in
                shouldRequestMoreItems = false
            }
            .refreshable {
                self.model.reloadItems(sortOrder: sortOrder)
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
            .onChange(of: sortOrder) { newOrder in
                self.model.reloadItems(sortOrder: newOrder)
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
        BreedsImagesView(model: model, availableWidth: 430)
    }
}
