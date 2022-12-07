//
//  SceneDelegate.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // creating PokemonListVC 
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let nc = PokemonListViewBuilder().buildWithNavigationController()
        window.rootViewController = nc
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }


}

