//
//  Constants.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

struct K {
    static let pokemonRequestLimit = 25
    
    static let pokemonDetailViewControllerID = "PokemonDetailViewController"
    static let pokemonListViewControllerID = "PokemonListViewController"
    
    static let pokemonListTableViewCellID = "pokemonlistcellid"
    static let loadingTableViewCellID = "loadingcellid"
    
    struct apiURLs {
        static let apiURL = "https://pokeapi.co/api/v2/pokemon"
        static let frontDefaultURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        static let homeFrontDefaultURl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
        static let offArtFrontDefaultURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    }
}
