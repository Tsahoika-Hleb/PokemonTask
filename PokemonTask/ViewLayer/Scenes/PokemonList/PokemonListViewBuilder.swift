//
//  PokemonListBuilder.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

struct PokemonListViewBuilder: ViewBuilderSpec {
    
    func build() -> PokemonListViewController {
        
        //let vc = UIStoryboard.instantiateViewController()
        //let vc = UIStoryboard.main.instantiateViewController(withClass: PokemonListViewController.self)
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: K.pokemonListViewControllerID) as! PokemonListViewController
        vc.presenter = PokemonListPresenter(router: PokemonListRouter(performer: vc))
        //vc.presenter.eventReceiver = vc  // TODO: add functionality
        return vc
    }
    
}
