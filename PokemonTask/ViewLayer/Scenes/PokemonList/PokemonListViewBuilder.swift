//
//  PokemonListBuilder.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

struct PokemonListViewBuilder: ViewBuilderSpec {
    
    func build() -> PokemonListViewController {
        
        let remoteRepository = RemotePokemonRepository(fetcher: PokemonListFetcher())
        let fetchPokemonUseCase = FetchPokemonListUseCase(repository: remoteRepository)
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: K.pokemonListViewControllerID) as! PokemonListViewController
        vc.presenter = PokemonListPresenter(fetchPokemonUseCase: fetchPokemonUseCase, router: PokemonListRouter(performer: vc))
        vc.presenter.eventReceiver = vc
        
        return vc
    }
    
}
