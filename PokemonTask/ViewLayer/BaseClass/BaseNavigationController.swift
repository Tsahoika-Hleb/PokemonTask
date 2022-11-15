//
//  BaseNavigationController.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 15.11.22.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatedTheme()
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func updatedTheme() {
        
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
    }
}

