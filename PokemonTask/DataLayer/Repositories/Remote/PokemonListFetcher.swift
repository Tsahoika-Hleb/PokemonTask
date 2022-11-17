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
        
        for id in 1...K.pokemonRequestLimit {
            DispatchQueue.global().sync {
                PokemonApiManager.shared.fetchPokemon(id: id + PokemonApiManager.shared.currentOffset) { (response) in
                    pokemonModelArray.append(response)
                    print("\(response.name) \(response.id)")
                } fail: {
                    print("Fail")
                    completionHandler(Result.failure(NetworkError.decode))
                }
                ImageDataManager.shared.fetchImage(url: "\(K.apiURLs.frontDefaultURL)\(id + PokemonApiManager.shared.currentOffset).png") { (response) in
                    fdsArray.append((response, id))
                    print("FD|\(id)|\(response)")
                } fail: {
                    print("Fail download fd")
                    completionHandler(Result.failure(NetworkError.decode))
                }
                ImageDataManager.shared.fetchImage(url: "\(K.apiURLs.homeFrontDefaultURl)\(id + PokemonApiManager.shared.currentOffset).png") { (response) in
                    print("HFD|\(id)|\(response)")
                    hfdsArray.append((response, id))
                } fail: {
                    print("Fail download hfd")
                    completionHandler(Result.failure(NetworkError.decode))
                }
                ImageDataManager.shared.fetchImage(url: "\(K.apiURLs.offArtFrontDefaultURL)\(id + PokemonApiManager.shared.currentOffset).png") { (response) in
                    print("OAFD|\(id)|\(response)")
                    oafdsArray.append((response, id))
                } fail: {
                    print("Fail download oafd")
                    completionHandler(Result.failure(NetworkError.decode))
                }
            }
        }
        PokemonApiManager.shared.currentOffset += K.pokemonRequestLimit
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            pokemonModelArray = pokemonModelArray.sorted{$0.id < $1.id}
            fdsArray = fdsArray.sorted {$0.1 < $1.1}
            hfdsArray = hfdsArray.sorted {$0.1 < $1.1}
            oafdsArray = oafdsArray.sorted {$0.1 < $1.1}
            for index in 0..<K.pokemonRequestLimit {
                pokemonModelArray[index].frontDefault = fdsArray[index].0
                pokemonModelArray[index].homeFrontDefault = hfdsArray[index].0
                pokemonModelArray[index].offArtFrontDefault = oafdsArray[index].0
            }
            
            
            if !pokemonModelArray.isEmpty {
                completionHandler(Result.success(pokemonModelArray))
            } else {
                completionHandler(Result.failure(NetworkError.decode))
            }
            
        }
        
    }
    
}
