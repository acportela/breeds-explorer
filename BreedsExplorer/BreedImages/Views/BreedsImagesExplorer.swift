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

    var state: ViewState {
        model.images == nil ? .loading : .content
    }

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
                    self.model.fetchBreedsImages(page: 0, order: .random)
                }
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
            Picker("", selection: $layoutConfiguration) {
                ForEach(LayoutConfiguration.allCases) { config in
                    Label(config.title, systemImage: config.icon).tag(config)
                }
            }
            .pickerStyle(.inline)
        } label: {
            Label("", systemImage: layoutConfiguration.icon).labelStyle(.iconOnly)
        }
    }
}

private enum LayoutConfiguration: String, CaseIterable, Identifiable {

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

struct BreedsImagesExplorer_Previews: PreviewProvider {

    static var previews: some View {
        BreedsImagesExplorer(model: BreedsImagesModel(breedsProvider: BreedsImagesProviderMock()))
    }
}
