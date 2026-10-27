//
//  SceneDelegate.swift
//  natto
//
//  Created by 佐川晴海 on 2026/10/28.
//  Copyright © 2026 佐川　晴海. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = NattoViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
