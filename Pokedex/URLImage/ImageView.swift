//
//  ImageView.swift
//  Pokedex
//
//  Created by Ria Narang on 2023-09-21.
//

import SwiftUI
import URLImage


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
