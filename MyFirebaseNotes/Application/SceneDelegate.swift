//
//  SceneDelegate.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 11.06.2024.
//

import UIKit
import Firebase

enum VCType {
    case signUp
    case signIn
    case tabBar
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
   
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        if let _ = Auth.auth().currentUser {
            window?.rootViewController = CustomTabBarController()
        } else {
            window?.rootViewController = SignUpViewController()
        }
        
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setVC), name: .setVC, object: nil)
    }
    
    @objc func setVC(notification: Notification) {
        guard let userInfo = notification.userInfo, let vcType = userInfo["vcType"] as? VCType else { return }
        
        switch vcType {
        case .signUp: window?.rootViewController = SignUpViewController()
        case .signIn: window?.rootViewController = SignInViewController()
        case .tabBar: window?.rootViewController = CustomTabBarController()
        }
    }
}

