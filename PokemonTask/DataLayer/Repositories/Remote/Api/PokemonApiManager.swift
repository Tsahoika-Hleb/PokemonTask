//
//  PokemonApiManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

class PokemonApiManager {
    public static let shared = PokemonApiManager()
    let pokemonRequestLimit = 30
    var currentOffset = 0
    
    
    func fetchPokemonModels() {

        var arr: [PokemonModel] = []
        for id in 1...pokemonRequestLimit {
            fetchPokemon(id: id + currentOffset) { (response) in
                arr.append(response)
                print("\(response.name) \(response.id)")
            } fail: {
                print("Fail")
            }

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print(arr.count)
        }
        print(arr.count)
    }
    
    func fetchPokemon(id: Int, success: @escaping ((PokemonModel) -> Void), fail: @escaping (() -> Void)) {
        NetworkServiceManger.shared.callNetworkService(urlString: "\(K.apiURL)/\(id)/") { (response: PokemonModel) in
            success(response)
        } fail: {
            fail()
        }
    }
}
