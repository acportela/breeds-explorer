//
//  BreedsSearchView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedsSearchView: View {

    @StateObject var model: BreedsSearchModel

    var isFetching: Bool {
        if case.loading = model.state.viewState {
            return true
        }
        return false
    }

    var body: some View {
        LoadingView(isLoading: isFetching) {
            ZStack {
                List {
                    Section {
                        ForEach(model.filteredBreeds) { breed in
                            BreedsSearchItem(breed: breed)
                        }
                        .listRowInsets(.init(top: 16, leading: 24, bottom: 16, trailing: 24))
                    }
                }
            }
            .searchable(text: $model.state.searchTerm, prompt: String.searchForBreedPrompt)
            .onAppear {
                if model.filteredBreeds.isEmpty {
                    model.fetchBreeds()
                }
            }
            .refreshable {
                model.fetchBreeds()
            }
            .setupErrorAlert(with: $model.isPresentingError,
                             error: model.lastPresentedError) {
                model.fetchBreeds()
            }
            .background(Color.breedsSecondaryColor)
            .navigationTitle(String.breeds)
            .navigationTitle(String.search)
            .navigationDestination(for: Breed.self) { breed in
                BreedDetail(breed: breed)
            }
        }
    }
}

private extension String {

    static let navigationTitle = "Search"
    static let searchForBreedPrompt = "Search for a breed"
}

struct SearchBreeds_Previews: PreviewProvider {
    static var previews: some View {
        BreedsSearchView(model: BreedsSearchModel(provider: BreedsSearchProviderMock()))
    }
}
