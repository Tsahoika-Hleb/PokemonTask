//
//  PokemonListPresenter.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

protocol PokemonListPresenterSpec {
    
    var rowOfList: Int { get }
    
    func updateList()
    func didSelect(at row: Int)
    func getCellModel(by row: Int) -> PokemonListCellModel
}

struct PokemonListViewSetupModel {
    let title: String
}

class PokemonListPresenter: PokemonListPresenterSpec {
    
    var rowOfList: Int {return pokemon.count}
    var isNowLoading = false
    
    init(router: PokemonListRouter) {
        
        self.router = router
    }
    
    func updateList() {
        isNowLoading = false
        fetchPokemon()
    }
    
    func getCellModel(by row: Int) -> PokemonListCellModel {
        let thePokemon = pokemon[row]
        return PokemonListCellModel(image: thePokemon.imageName, name: thePokemon.name)
    }
    
    func didSelect(at row: Int) {
        let thePokemon = pokemon[row]
        // TODO: vc.performSegue(withIdentifier: K.listToDetailSegue, sender: ????)
        router.pushDetailView(with: thePokemon)
    }
    
    // MARK: Private
    private var pokemon: [PokemonModel] = []
    private let router: PokemonListRouter
    
    // TODO: fetchPokemonData
    private func fetchPokemon() {
        for i in 1...30 {
            pokemon += [PokemonModel(name: "pok\(i)")]
        }
    }
}
