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

//    func temp() {  // TODO: delete
//        PokemonApiManager.shared.fetchPokemons { PokemonApiListModel in
//            for i in 0..<20 {
//                print(PokemonApiListModel.results[i].name)
//            }
//        } fail: {
//            print("Fail")
//        }
//    }
    
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchPokemonList(completionHandler)
    }
    
    
    // MARK: private
    
    private let repository: PokemonRepositorySpec
}
