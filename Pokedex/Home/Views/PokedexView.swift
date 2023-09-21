//
//  PokedexView.swift
//  Pokedex
//
//  Created by Ria Narang on 2023-09-19.
//

import SwiftUI
import URLImage

// MARK: - PokedexView

struct PokedexView: View {
    @ObservedObject private var viewModel = PokedexViewModel()
    @State private var selectedPokemon: PokemonListItem?
    
    private var pokemons: [PokemonListItem] {
        viewModel.pokemonList
    }
    
   var body: some View {
       VStack {
           if let errorMessage = viewModel.errorMessage {
               Text(errorMessage)
                   .foregroundColor(.red)
           } else {
               SelectedPokemonView(selectedPokemon: selectedPokemon)
               PokemonGridView(viewModel: viewModel, pokemons: pokemons, selectedPokemon: $selectedPokemon, loadMoreData: {
                   viewModel.loadMoreData()
               })
           }

       }
       .onAppear {
           // inital data fetching
           viewModel.fetchPokemonList(limit: 20, offset: 0)
       }
   }
}
