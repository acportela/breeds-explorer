//
//  BreedsSearchModel.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import Foundation
import Combine

struct BreedsSearchState {

    enum PresentingState {
        case loading
        case content(breeds: [Breed])
    }

    var searchTerm = ""
    fileprivate (set) var viewState = PresentingState.content(breeds: [])
}

@MainActor
final class BreedsSearchModel: ObservableObject {

    @Published var state = BreedsSearchState() {
        didSet {
            if case.content(let allBreeds) = state.viewState {
                self.filteredBreeds = allBreeds
            }
        }
    }

    @Published var filteredBreeds: [Breed] = []

    @Published var isPresentingError: Bool = false
    private (set) var lastPresentedError: BreedsRequestError = .unknownError

    private var searchPublisher: AnyCancellable?
    private let provider: BreedsSearchProviderProtocol

    init(provider: BreedsSearchProviderProtocol) {

        self.provider = provider
        self.configureSearchPublisher()
    }

    deinit {

        self.searchPublisher?.cancel()
    }

    func fetchBreeds() {

        self.state.viewState = .loading

        Task {
            do {
                let breeds = try await provider.fetchAllBreeds()
                self.state.viewState = .content(breeds: breeds)
            } catch {
                self.handleError(error)
            }
        }
    }
}

private extension BreedsSearchModel {

    func handleError(_ error: Error) {

        self.state.searchTerm = ""
        self.state.viewState = .content(breeds: [])
        self.isPresentingError = true
        self.lastPresentedError = (error as? BreedsRequestError) ?? .unknownError
    }

    func configureSearchPublisher() {

        self.searchPublisher = $state
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .map { [weak self] state in
                guard let self = self else { return [] }
                switch state.viewState {
                case .loading: return self.filteredBreeds
                case .content(let breeds):
                    guard state.searchTerm.count > 2 else { return self.filteredBreeds }
                    return breeds.filter { $0.name.localizedCaseInsensitiveContains(state.searchTerm) }
                }
            }
            .sink { [weak self] breeds in
                self?.filteredBreeds = breeds
            }
    }
}
