//
//  RemotePokemonsRepository.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

struct RemotePokemonRepository<AnyNetworkFetchable>: PokemonRepositorySpec where AnyNetworkFetchable: NetworkFetchable, AnyNetworkFetchable.DataModel == [PokemonModel] {
    
    init(fetcher: AnyNetworkFetchable) {
        self.fetcher = fetcher
    }
    
    func fetchPokemonList(_ completionHandler: @escaping FetchPokemonsCompletionHandler) {
        var res: [PokemonModel] = []
        
        fetcher.fire { (result) in
            switch result {
            case .success(let dataModel):
                res = dataModel.sorted { $0.id < $1.id }
                completionHandler(Result.success(res))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
    
    // MARK: private
    
    private let fetcher: AnyNetworkFetchable
}
