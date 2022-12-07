//
//  ImagaDataManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 17.11.22.
//

import Foundation

class ImageDataManager {
    // Fetch image data by URL
    func fetchImage(url: String, success: @escaping ((Data) -> Void), fail: @escaping (() -> Void)) {
        let url = URL(string: url)
        guard let urlObj = url else { return }
        let session = URLSession.shared
        let request = URLRequest(url: urlObj)
    
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            guard error == nil else { return }
            guard let safeData = data else { return }
            success(safeData)
        })
        task.resume()
    }
}
