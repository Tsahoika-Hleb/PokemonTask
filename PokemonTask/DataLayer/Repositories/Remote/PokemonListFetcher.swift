//
//  PokemonListFetcher.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

struct PokemonListFetcher: NetworkFetchable {

    typealias DataModel = [PokemonModel]

    func fire(_ completionHandler: @escaping (Result<[PokemonModel], NetworkError>) -> ()) {
        
        var pokemonModelArray: [PokemonModel] = []
        for id in 1...PokemonApiManager.shared.pokemonRequestLimit {
            PokemonApiManager.shared.fetchPokemon(id: id + PokemonApiManager.shared.currentOffset) { (response) in
                pokemonModelArray.append(response)
                print("\(response.name) \(response.id)")
            } fail: {
                print("Fail")
            }

        }
        PokemonApiManager.shared.currentOffset += PokemonApiManager.shared.pokemonRequestLimit
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            
            if !pokemonModelArray.isEmpty {
                completionHandler(Result.success(pokemonModelArray))
            } else {
                completionHandler(Result.failure(NetworkError.decode))
            }
            
        }
        
    }
    
}
