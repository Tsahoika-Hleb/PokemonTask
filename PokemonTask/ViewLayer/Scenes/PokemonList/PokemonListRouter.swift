//
//  PokemonListRouter.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

protocol PokemonListRouterSpec {
    func pushDetailView(with pokemon: PokemonModel)
}

struct PokemonListRouter: PokemonListRouterSpec {
    
    init(performer: PokemonListViewController) {
        self.performer = performer
    }
    
    func pushDetailView(with pokemon: PokemonModel) {
        // TODO: CHECK
        let vc = PokemonDetailViewBuilder(pokemon: pokemon).build()
        performer.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: private
    private weak var performer: PokemonListViewController!
}
