//
//  SceneDelegate.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-07-23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()

        self.window = window
    }
}

