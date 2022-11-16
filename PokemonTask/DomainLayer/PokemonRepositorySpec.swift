//
//  PokemonRepositorySpec.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

protocol PokemonRepositorySpec {
    
    typealias FetchPokemonsCompletionHandler = (Result<[PokemonModel], Error>) -> ()
    func fetchPokemonList(_ completionHandler: @escaping FetchPokemonsCompletionHandler)
}
