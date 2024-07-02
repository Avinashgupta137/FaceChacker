//
//  SceneDelegate.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = AppRouter_FaceChecker_UPD.shared.navigationController
        window?.makeKeyAndVisible()
    }
}
