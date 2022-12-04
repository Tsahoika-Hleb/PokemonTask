//
//  LocalPokemonRepository.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 18.11.22.
//

import Foundation
import CoreData

protocol LocalPokemonRepositorySpec: PokemonRepositorySpec {
    
    typealias SavePokemonsComplitionHandler = (Result<Void, Error>) -> ()
    func save(pokemon: [PokemonModel], completionHandler: SavePokemonsComplitionHandler?)
}

enum LocalPokemonRepositoryError: Error {
    case noLocalCache
}

/// Cache PokemonModel to CoreData
struct LocalPokemonRepository: LocalPokemonRepositorySpec {
    func save(pokemon: [PokemonModel], completionHandler: SavePokemonsComplitionHandler?) {
        for item in pokemon {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let pokemonToSave = PokemonMO(context: managedContext)
            var typesStringArray: [String] = []
            for i in item.types {
                typesStringArray.append(i.type.name)
            }
            let typesArrayData = try? JSONSerialization.data(withJSONObject: typesStringArray, options: [])
            pokemonToSave.setValue(item.id, forKey: K.pokemonMOProperties.id)
            pokemonToSave.setValue(item.name, forKey: K.pokemonMOProperties.name)
            pokemonToSave.setValue(item.offArtFrontDefault, forKey: K.pokemonMOProperties.offArtFrontDefault)
            pokemonToSave.setValue(item.frontDefault, forKey: K.pokemonMOProperties.frontDefault)
            pokemonToSave.setValue(item.height, forKey: K.pokemonMOProperties.height)
            pokemonToSave.setValue(item.homeFrontDefault, forKey: K.pokemonMOProperties.homeFrontDefault)
            pokemonToSave.setValue(typesArrayData, forKey: K.pokemonMOProperties.types)
            pokemonToSave.setValue(item.weight, forKey: K.pokemonMOProperties.weight)
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        }
        completionHandler?(Result.success(()))
    }
    
    func fetchPokemonList(_ completionHandler: @escaping FetchPokemonsCompletionHandler) {
        let pokemonsFetch: NSFetchRequest<PokemonMO> = PokemonMO.fetchRequest()
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(pokemonsFetch)
            
            var pokemons: [PokemonModel] = []
            for item in results {
                var typesArray: [PokemonModel.PokemonType] = []
                let typesStrAarray = (try? JSONSerialization.jsonObject(with: item.types!, options: [])) as? [String]
                for typeName in typesStrAarray! {
                    typesArray.append(PokemonModel.PokemonType(type: PokemonModel.PokemonTypeName(name: typeName)))
                }
                pokemons.append(PokemonModel(name: item.name!, height: Int(item.height), weight: Int(item.weight),
                                             types: typesArray, id: Int(item.id),
                                             frontDefault: item.frontDefault,
                                             homeFrontDefault: item.homeFrontDefault,
                                             offArtFrontDefault: item.offArtFrontDefault))
            }
            if pokemons.isEmpty {
                completionHandler(Result.failure(LocalPokemonRepositoryError.noLocalCache))
            } else {
                completionHandler(Result.success(pokemons))
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    static func removeAll() {
        let pokemonsFetch: NSFetchRequest<PokemonMO> = PokemonMO.fetchRequest()
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(pokemonsFetch)
            for item in results {
                managedContext.delete(item)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}
