//
//  ApiManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 16.11.22.
//

import Foundation

class NetworkServiceManger {
    public static let shared = NetworkServiceManger()
    
    func callNetworkService<T: Decodable>(urlString: String, success: @escaping ((T) -> Void), fail: @escaping (() -> Void)) {
        let url = URL(string: urlString)
        guard let urlObj = url else { return }
        let session = URLSession.shared
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET" // TODO: chek by default
        request.addValue("application/json", forHTTPHeaderField: "Accpet")
    
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            guard error == nil else {
                return }
            guard let safeData = data else {
                return }
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(T.self, from: safeData) {
                success(jsonData)
            } else {
                fail()
            }
        })
        task.resume()
    }
}
