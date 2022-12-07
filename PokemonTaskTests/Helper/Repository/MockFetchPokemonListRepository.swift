//
//  MockFetchPokemonListRepository.swift
//  PokemonTaskTests
//
//  Created by Hleb Tsahoika on 7.12.22.
//

@testable import PokemonTask

enum MockFetchPokemonListRepositoryError: Error {
    case fail
}

class MockFetchPokemonListRepository: PokemonRepositorySpec {
    
    var expectedResult: Result<[PokemonModel], Error>!
    
    func fetchPokemonList(_ completionHandler: @escaping FetchPokemonsCompletionHandler) {
        completionHandler(expectedResult)
    }
}
