// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()

        self.window = window
    }
}
