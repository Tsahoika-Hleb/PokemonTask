//
//  PokemonListBuilder.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

struct PokemonListViewBuilder: ViewBuilderSpec {
    
    func build() -> PokemonListViewController {
        
        let remoteRepository = RemotePokemonRepository(fetcher: PokemonListFetcher(pokemonApiManage: PokemonApiManager(), imageDataManager: ImageDataManager()))
        let cacheRepository = CachePokemonRepository(remoteRepository: remoteRepository, localRepository: LocalPokemonRepository())
        let fetchLocalPokemonUseCase = FetchPokemonListUseCase(repository: LocalPokemonRepository())
        let fetchPokemonUseCase = FetchPokemonListUseCase(repository: cacheRepository)
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: K.pokemonListViewControllerID) as! PokemonListViewController
        vc.presenter = PokemonListPresenter(fetchPokemonUseCase: fetchPokemonUseCase,
                                            fetchLocalPokemonUseCaseSpec: fetchLocalPokemonUseCase,
                                            router: PokemonListRouter(performer: vc))
        vc.presenter.eventReceiver = vc
        
        return vc
    }
    
}
