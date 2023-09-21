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
           if  viewModel.isLoading{
               ProgressView("Loading...")
           } else if let errorMessage = viewModel.errorMessage {
               Text(errorMessage)
                   .foregroundColor(.red)
           } else {
               SelectedPokemonView(selectedPokemon: selectedPokemon)
               PokemonGridView(pokemons: pokemons, selectedPokemon: $selectedPokemon)
           }

       }
       .onAppear {
           viewModel.fetchPokemonList(limit: 20, offset: 0)
       }
   }
}


// MARK: - PokemonItemView

struct PokemonItemView: View {
    let pokemon: PokemonListItem

    var body: some View {
        VStack {
            if let imageURL = pokemon.spriteURL {
                ImageView(imageUrl: imageURL)
            }

            Text(pokemon.name.capitalized)
        }
        .padding()
    }
}


// MARK: - PokemonGridView

struct PokemonGridView: View {
    let pokemons: [PokemonListItem]
    @Binding var selectedPokemon: PokemonListItem?

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(pokemons, id: \.name) { pokemon in
                    PokemonItemView(pokemon: pokemon)
                        .onTapGesture {
                            selectedPokemon = pokemon
                        }
                }
            }
            .padding()
        }
    }
}

// MARK: - SelectedPokemonView

struct SelectedPokemonView: View {
    let selectedPokemon: PokemonListItem?

    var body: some View {
        VStack {
            if let pokemon = selectedPokemon {
                Text("Selected Pokémon:")
                    .font(.headline)
                if let imageURL = pokemon.spriteURL {
                    ImageView(imageUrl: imageURL)
                }
                Text(pokemon.name.capitalized)
            } else {
                Text("No Pokémon selected")
            }
        }
        .padding()
    }
}

// MARK: - ImageView


struct ImageView: View {
    let imageUrl: URL

    // add error handling
    var body: some View {
        URLImage(imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: 100, height: 100)

    }
}

// add previews

