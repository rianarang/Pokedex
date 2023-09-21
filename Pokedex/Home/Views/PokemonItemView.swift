//
//  PokemonItemView.swift
//  Pokedex
//
//  Created by Ria Narang on 2023-09-21.
//

import SwiftUI

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
