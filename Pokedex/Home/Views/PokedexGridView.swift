//
//  PokedexGridView.swift
//  Pokedex
//
//  Created by Ria Narang on 2023-09-21.
//

import Foundation
import SwiftUI

// MARK: - PokemonGridView

struct PokemonGridView: View {
    let viewModel: PokedexViewModel
    let pokemons: [PokemonListItem]
    @Binding var selectedPokemon: PokemonListItem?
    let loadMoreData: () -> Void
    @State private var scrollToIndex: Int? = nil // Store the scroll offset

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(pokemons, id: \.name) { pokemon in
                    PokemonItemView(pokemon: pokemon)
                        .onTapGesture {
                            selectedPokemon = pokemon
                        }
                        .task {
                            if viewModel.hasReachedEnd(of: pokemon) && !viewModel.isLoading {
                                viewModel.loadMoreData()
                            }
                        }
                }
            }
            .padding()
            .overlay(alignment: .bottom) {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }

}
