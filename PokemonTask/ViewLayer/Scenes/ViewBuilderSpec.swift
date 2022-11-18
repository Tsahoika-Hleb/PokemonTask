//
//  ViewBuilderSpec.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

protocol ViewBuilderSpec {
    
    associatedtype ViewType: UIViewController
    
    func build() -> ViewType
    func buildWithNavigationController() -> BaseNavigationController
}

extension ViewBuilderSpec {

    func buildWithNavigationController() -> BaseNavigationController {
        let nc = BaseNavigationController(rootViewController: build())
        return nc
    }
}
