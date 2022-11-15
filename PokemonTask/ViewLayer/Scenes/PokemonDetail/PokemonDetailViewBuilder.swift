//
//  PokemonDetailBuilder.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

struct PokemonDetailViewBuilder {
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    func build() -> PokemonDetailViewController {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: K.pokemonDetailViewControllerID) as! PokemonDetailViewController
        vc.presenter = PokemonDetailPresenter(pokemon: pokemon)
        return vc
    }
    
    // MARK: private
    
    private let pokemon: PokemonModel
}
