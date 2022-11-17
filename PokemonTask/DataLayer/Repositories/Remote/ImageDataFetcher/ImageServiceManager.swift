//
//  ImageServiceManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 17.11.22.
//

import Foundation

class ImageServiceManger {
    public static let shared = ImageServiceManger()
    
    func callImageService(urlString: String, success: @escaping ((Data) -> Void), fail: @escaping (() -> Void)) {
        let url = URL(string: urlString)
        guard let urlObj = url else { return }
        let session = URLSession.shared
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET" // TODO: chek by default
        request.addValue("application/json", forHTTPHeaderField: "Accpet")
    
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            
            guard error == nil else { return }
            guard let safeData = data else { return }
            success(safeData)

        })
        task.resume()
    }
}
