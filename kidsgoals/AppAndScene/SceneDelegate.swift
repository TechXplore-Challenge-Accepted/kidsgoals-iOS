//
//  SceneDelegate.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let viewModel = MainViewModel()
        let navigationController = UINavigationController(rootViewController: MainView(viewModel: viewModel))
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
