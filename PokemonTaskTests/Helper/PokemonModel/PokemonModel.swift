//
//  PokemonModel.swift
//  PokemonTaskTests
//
//  Created by Hleb Tsahoika on 7.12.22.
//

@testable import PokemonTask

extension PokemonModel {
    
    static var newPokemon: PokemonModel {
        return PokemonModel(name: "bulbasaur", height: 7, weight: 69, types: [PokemonType(type: PokemonTypeName(name: "Grass")), PokemonType(type: PokemonTypeName(name: "Poison"))], id: 1)
    }
}

extension PokemonModel: Equatable {
    
    public static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        let lTemp:String = lhs.pokTypesArrToStr(types: lhs.types)
        let rTemp:String = rhs.pokTypesArrToStr(types: rhs.types)
        return lhs.name + String(lhs.height) + String(lhs.weight) + lTemp + String(lhs.id) ==
                    rhs.name + String(rhs.height) + String(rhs.weight) + rTemp + String(rhs.id)
        
    }
    
    private func pokTypesArrToStr (types: [PokemonModel.PokemonType]) -> String {
        var temp: [String] = []
        for item in types {
            temp.append(item.type.name)
        }
        return temp.joined()
    }
}
