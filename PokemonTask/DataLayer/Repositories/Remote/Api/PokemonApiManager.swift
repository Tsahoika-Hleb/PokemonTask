//
//  PokemonApiManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation


class PokemonApiManager {
    public static let shared = PokemonApiManager()
    
    // fetch pokemon data by id
    func fetchPokemon(id: Int, success: @escaping ((PokemonModel) -> Void), fail: @escaping (() -> Void)) {
        NetworkServiceManger.shared.callNetworkService(urlString: "\(K.apiURLs.apiURL)/\(id)/") { (response: PokemonModel) in
            success(response)
        } fail: {
            fail()
        }
    }
}
