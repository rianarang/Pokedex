import Foundation
import Combine

class PokedexViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: PokedexRepository
    private var cancellables: Set<AnyCancellable> = []

    init(repository: PokedexRepository = PokedexRepository()) {
        self.repository = repository
    }

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
}
