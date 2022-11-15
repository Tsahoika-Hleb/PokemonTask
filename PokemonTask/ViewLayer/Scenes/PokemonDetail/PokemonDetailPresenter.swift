//
//  PokemonDetailPresenter.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

protocol PokemonDetailPresenterSpec {
    
}

class PokemonDetailPresenter: PokemonDetailPresenterSpec {
    
    init(pokemon: PokemonModel){
        self.pokemon = pokemon
    }
    
    // MARK: Private
    
    private let pokemon: PokemonModel
}
