//
//  ImagaDataManager.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 17.11.22.
//

import Foundation

class ImageDataManager {
    public static let shared = ImageDataManager()
    var curruntOffset = 0
    
    func fetchImage(url: String, success: @escaping ((Data) -> Void), fail: @escaping (() -> Void)) {
        ImageServiceManger.shared.callImageService(urlString: url) { (response: Data) in
            success(response)
        } fail: {
            fail()
        }
    }
}
