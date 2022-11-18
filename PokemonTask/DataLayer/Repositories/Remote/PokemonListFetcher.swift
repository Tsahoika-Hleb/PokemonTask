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
        var fdsArray: [(Data, Int)] = []
        var hfdsArray:  [(Data, Int)] = []
        var oafdsArray:  [(Data, Int)] = []
        
        // Fetch array of PokemonModel and 3 arrays of each sprite 
        for id in 1...K.pokemonRequestLimit {
            PokemonApiManager.shared.fetchPokemon(id: id + K.currentOffset) { (response) in
                pokemonModelArray.append(response)
            } fail: {
                completionHandler(Result.failure(NetworkError.connection))
            }
            ImageDataManager.shared.fetchImage(url: "\(K.apiURLs.frontDefaultURL)\(id + K.currentOffset).png") { (response) in
                fdsArray.append((response, id))
            } fail: {
                completionHandler(Result.failure(NetworkError.connection))
            }
            ImageDataManager.shared.fetchImage(url: "\(K.apiURLs.homeFrontDefaultURl)\(id + K.currentOffset).png") { (response) in
                hfdsArray.append((response, id))
            } fail: {
                completionHandler(Result.failure(NetworkError.connection))
            }
            ImageDataManager.shared.fetchImage(url: "\(K.apiURLs.offArtFrontDefaultURL)\(id + K.currentOffset).png") { (response) in
                oafdsArray.append((response, id))
            } fail: {
                completionHandler(Result.failure(NetworkError.connection))
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {  // TODO: Ask
            if !pokemonModelArray.isEmpty, fdsArray.count == pokemonModelArray.count,
                hfdsArray.count == pokemonModelArray.count, oafdsArray.count == pokemonModelArray.count {
                pokemonModelArray = pokemonModelArray.sorted{$0.id < $1.id}
                fdsArray = fdsArray.sorted {$0.1 < $1.1}
                hfdsArray = hfdsArray.sorted {$0.1 < $1.1}
                oafdsArray = oafdsArray.sorted {$0.1 < $1.1}
                for index in 0..<K.pokemonRequestLimit {
                    pokemonModelArray[index].frontDefault = fdsArray[index].0
                    pokemonModelArray[index].homeFrontDefault = hfdsArray[index].0
                    pokemonModelArray[index].offArtFrontDefault = oafdsArray[index].0
                }
                completionHandler(Result.success(pokemonModelArray))
            } else {
                if pokemonModelArray.isEmpty {
                    completionHandler(Result.failure(NetworkError.connection))
                } else {
                    completionHandler(Result.failure(NetworkError.serviceError))
                }
            }
            
        }
        
    }
    
}
