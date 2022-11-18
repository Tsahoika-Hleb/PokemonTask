//
//  LocalPokemonRepository.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 18.11.22.
//

import Foundation

protocol LocalPokemonRepositorySpec: PokemonRepositorySpec {
    
    typealias SavePokemonsComplitionHandler = (Result<Void, Error>) -> ()
    func save(pokemon: [PokemonModel], completionHandler: SavePokemonsComplitionHandler?)
}

enum LocalPokemonRepositoryError: Error {
    case noLocalCache
}

/// Cache PokemonModel to userDefaults
struct LocalPokemonRepository: LocalPokemonRepositorySpec {
    func save(pokemon: [PokemonModel], completionHandler: SavePokemonsComplitionHandler?) {
        do {
            var pokemonData = try JSONEncoder().encode(pokemon)
            guard let data = UserDefaults.standard.data(forKey: K.localPokemonListPersistKey) else {
                UserDefaults.standard.set(pokemonData, forKey: K.localPokemonListPersistKey)
                completionHandler?(Result.success(()))
                return
            }
    
            do {
                var existingData = try JSONDecoder().decode([PokemonModel].self, from: data)
                for item in pokemon {
                    existingData.append(item)
                }
                existingData = existingData.sorted {$0.id < $1.id}
                pokemonData = try JSONEncoder().encode(existingData)
                UserDefaults.standard.set(pokemonData, forKey: K.localPokemonListPersistKey)
            } catch {
                completionHandler?(Result.failure(error))
            }
            
            completionHandler?(Result.success(()))
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        } catch {
            completionHandler?(Result.failure(error))
        }
    }
    
    func fetchPokemonList(_ completionHandler: @escaping FetchPokemonsCompletionHandler) {
        print("fetch local")
        guard let data = UserDefaults.standard.data(forKey: K.localPokemonListPersistKey) else {
            completionHandler(Result.failure(LocalPokemonRepositoryError.noLocalCache))
            return
        }
        do {
            let dataModel = try JSONDecoder().decode([PokemonModel].self, from: data)
            completionHandler(Result.success(dataModel))
        } catch {
            completionHandler(Result.failure(error))
        }
    }
    
    static func removeAll() {
        UserDefaults.standard.removeObject(forKey: K.localPokemonListPersistKey)
    }
    
}
