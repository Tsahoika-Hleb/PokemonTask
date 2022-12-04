//
//  Constants.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

struct K {
    static let pokemonRequestLimit = 15
    static var currentOffset = 0
    
    static let pokemonDetailViewControllerID = "PokemonDetailViewController"
    static let pokemonListViewControllerID = "PokemonListViewController"
    
    static let pokemonListTableViewCellID = "pokemonlistcellid"
    static let pokemonListCellNibName = "PokemonListTableViewCell"
    static let loadingTableViewCellID = "loadingcellid"
    static let loadingCellNibName = "LoadingTableViewCell"
    
    /// key for UserDefaults
    //static let localPokemonListPersistKey = "localPokemonListPersistKey"
    static let coreDataModelName = "Pokemons"

    struct apiURLs {
        static let apiURL = "https://pokeapi.co/api/v2/pokemon"
        
        static let frontDefaultURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        static let homeFrontDefaultURl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
        static let offArtFrontDefaultURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    }
    
    struct pokemonMOProperties {
        static let id = "id"
        static let name = "name"
        static let offArtFrontDefault  = "offArtFrontDefault"
        static let frontDefault = "frontDefault"
        static let height = "height"
        static let homeFrontDefault = "homeFrontDefault"
        static let types = "types"
        static let weight = "weight"
    }
}
