//
//  NetworkFetchable.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

enum NetworkError: Error {
    case url
    case encode
    case connection
    case decode
    case emptyContent
    case serviceError
}

protocol NetworkFetchable {
    
    associatedtype DataModel: Codable
    func fire(_ completionHandler: @escaping (Result<DataModel, NetworkError>) -> ())
}
