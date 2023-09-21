//
//  PokedexRepository.swift
//  Pokedex
//
//  Created by Ria Narang on 2023-09-19.
//

import Combine
import Foundation

// MARK: - PokedexRepository

class PokedexRepository {
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon"

    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<[PokemonListItem], Error> {
        let url = URL(string: "\(baseUrl)?limit=\(limit)&offset=\(offset)")!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonListResponse.self, decoder: JSONDecoder())
            .flatMap { response in
                Publishers.MergeMany(response.results.map { item in
                    URLSession.shared.dataTaskPublisher(for: URL(string: item.url)!)
                        .map(\.data)
                        .decode(type: PokemonDetailResponse.self, decoder: JSONDecoder())
                        .map { detailResponse in
                            var modifiedItem = item
                            modifiedItem.spriteURL = URL(string: detailResponse.sprites.frontDefault)
                            return modifiedItem
                        }
                })
            }
            .collect()
            .eraseToAnyPublisher()
    }
}

// MARK: - PokemonListResponse

struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}


// MARK: -PokemonListItem

struct PokemonListItem: Codable {
    let name: String
    let url: String
    var spriteURL: URL?
}


struct PokemonDetailResponse: Codable {
    let sprites: SpritesDetail

    struct SpritesDetail: Codable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

