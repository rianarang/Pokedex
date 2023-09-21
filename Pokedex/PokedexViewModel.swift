import Foundation
import Combine

class PokedexViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: PokedexRepository
    private var cancellables: Set<AnyCancellable> = []
    
    private var currentPage = 1
    private let itemsPerPage = 20

    init(repository: PokedexRepository = PokedexRepository()) {
        self.repository = repository
    }

    @MainActor
    func fetchPokemonList(limit: Int, offset: Int) {
        isLoading = true

        repository.fetchPokemonList(limit: limit, offset: offset)
            .receive(on: DispatchQueue.main) // Ensure updates are on the main thread
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] pokemonList in
                self?.pokemonList = pokemonList
            })
            .store(in: &cancellables)
    }
    
    @MainActor
    func loadMoreData() {
        guard !isLoading else { return }

        isLoading = true
        currentPage += 1

        repository.fetchPokemonList(limit: itemsPerPage, offset: (currentPage - 1) * itemsPerPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] newPokemonList in
                if newPokemonList.isEmpty {
                    // If the new list is empty, it means we've reached the end of the data
                    // You can handle this case as per your app's requirements
                } else {
                    // Append new data to the existing list
                    self?.pokemonList += newPokemonList
                }
            })
            .store(in: &cancellables)
    }
    
    func hasReachedEnd(of pokemon: PokemonListItem) -> Bool {
        pokemonList.last?.url == pokemon.url
    }
}
