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
    //let sprites: Sprites
    let id: Int
    
     
    var frontDefault: Data?
    var homeFrontDefault: Data?
    var offArtFrontDefault: Data?
    
    
//    struct Sprites: Codable {
//        let front_default: String
//        let other: OtherSprites
//    }
//
//    struct OtherSprites: Codable {
//        let dream_world: DreamWorld
//        let home: Home
//    }
//
//    struct DreamWorld: Codable {
//        let front_default: String
//    }
//
//    struct Home: Codable {
//        let front_default: String
//    }
    
    struct PokemonType: Codable {
        let type: PokemonTypeName
    }
    
    struct PokemonTypeName: Codable {
        let name: String
    }
    
    
}
