//
//  SelectedPokemonView.swift
//  Pokedex
//
//  Created by Ria Narang on 2023-09-21.
//

import Foundation
import SwiftUI


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
