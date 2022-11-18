//
//  FetchPokemonUseCase.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

struct FetchPokemonListUseCase: FetchDataUseCaseSpec {
    typealias DataModel = [PokemonModel]
        
    init(repository: PokemonRepositorySpec) {
        self.repository = repository
    }
    
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchPokemonList(completionHandler)
    }
    
    
    // MARK: private
    
    private let repository: PokemonRepositorySpec
}
