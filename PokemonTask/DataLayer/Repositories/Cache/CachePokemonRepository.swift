//
//  CachePokemonRepository.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 18.11.22.
//

import Foundation

struct CachePokemonRepository: PokemonRepositorySpec {
    
    init(remoteRepository: PokemonRepositorySpec, localRepository: LocalPokemonRepositorySpec) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    
    func fetchPokemonList(_ completionHandler: @escaping FetchPokemonsCompletionHandler) {
        remoteRepository.fetchPokemonList { (result) in
            switch result {
            case .success(let dataModel):
                self.localRepository.save(pokemon: dataModel, completionHandler: nil)
                completionHandler(result)
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
    
    // MARK: private
    
    private var remoteRepository: PokemonRepositorySpec // TODO: check
    private var localRepository: LocalPokemonRepositorySpec
    
}
