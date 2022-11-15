//
//  PokemonModel.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

struct PokemonModel {
    
    let name: String
    var imageName: String = "image"// TODO: ??
    let types: [String] = []
    let height: Float = 0 // in decimetres in api.
    let weight: Float = 0// in in hectograms in api.
    /*
    "sprites": {
        "front_default":
        "other": {
            "dream_world": {
                "front_default":
            }
            "home": {
                "front_default":
            }
        }
    }
     */
}
