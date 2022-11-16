//
//  FetchDataUseCaseSpec.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

protocol FetchDataUseCaseSpec {
    
    associatedtype DataModel
    
    typealias FetchDataModelUseCaseCompletionHandler = (_ books: Result<DataModel, Error>) -> ()
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler)
}
