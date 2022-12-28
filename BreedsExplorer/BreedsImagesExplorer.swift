//
//  BreedsImagesExplorer.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsImagesExplorer: View {

    @ObservedObject var model: BreedsModel
    @State var layoutConfiguration = LayoutConfiguration.grid

    var body: some View {

        ZStack {
            switch layoutConfiguration {
            case .grid:
                ScrollView {
                    BreedsGrid(breeds: model.breeds)
                }
            case .list:
                BreedsImageList(breeds: model.breeds)
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

struct BreedsImagesExplorer_Previews: PreviewProvider {

    static var previews: some View {

        BreedsImagesExplorer(model: BreedsModel())
    }
}
