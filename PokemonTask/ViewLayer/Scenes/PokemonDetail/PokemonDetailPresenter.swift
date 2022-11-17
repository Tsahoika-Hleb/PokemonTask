//
//  PokemonDetailPresenter.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

protocol PokemonDetailPresenterSpec {
    
    var eventReceiver: PokemonDetailViewEventReceiverable? { get set }
    
    func setup()
}

protocol PokemonDetailViewEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: PokemonDetailViewSetupModel)
}

struct PokemonDetailViewSetupModel {
    let name: String
    let height: Float
    let weight: Float
    let types: [String]
    let topImage: Data
    let botImage: Data
}

class PokemonDetailPresenter: PokemonDetailPresenterSpec {
    
    weak var eventReceiver: PokemonDetailViewEventReceiverable?
    
    init(pokemon: PokemonModel){
        self.pokemon = pokemon
    }
    
    func setup() {
        var types: [String] = []
        for item in pokemon.types {
            types.append(item.type.name)
        }
        
        let setupModel = PokemonDetailViewSetupModel(name: pokemon.name,
                                                     height: Float(pokemon.height) * 10,
                                                     weight: Float(pokemon.weight) / 10,
                                                     types: types,
                                                     topImage: pokemon.homeFrontDefault ?? Data(),
                                                     botImage: pokemon.offArtFrontDefault ?? Data())
        eventReceiver?.receivedEventOfSetupViews(with: setupModel)
    }
    
    // MARK: Private
    
    private let pokemon: PokemonModel
}
