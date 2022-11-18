//
//  PokemonModel.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

struct PokemonModel: Codable {    
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let id: Int
    
     
    var frontDefault: Data?
    var homeFrontDefault: Data?
    var offArtFrontDefault: Data?
        
    struct PokemonType: Codable {
        let type: PokemonTypeName
    }
    
    struct PokemonTypeName: Codable {
        let name: String
    }
    
    
}
