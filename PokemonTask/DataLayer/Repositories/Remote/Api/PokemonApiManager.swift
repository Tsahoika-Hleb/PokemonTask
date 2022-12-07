//
//  PokemonApiManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation


class PokemonApiManager {
    // fetch pokemon data by id
    func fetchPokemon(id: Int, success: @escaping ((PokemonModel) -> Void), fail: @escaping (() -> Void)) {
        let url = URL(string: "\(K.apiURLs.apiURL)/\(id)/")
        guard let urlObj = url else { return }
        let session = URLSession.shared
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET" 
        request.addValue("application/json", forHTTPHeaderField: "Accpet")
    
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            guard error == nil else {
                fail()
                return }
            guard let safeData = data else {
                return }
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(PokemonModel.self, from: safeData) {
                success(jsonData)
            } else {
                fail()
            }
        })
        task.resume()
    }
}
