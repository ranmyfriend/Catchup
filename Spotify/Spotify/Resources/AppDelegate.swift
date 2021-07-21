//
//  AppDelegate.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

protocol AuthManagerProtocol {
    
    var isSignedIn: Bool { get }
    
}

extension AuthManager: AuthManagerProtocol { }

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authManager: AuthManager = AuthManager.shared

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print(">> \(String(describing: AppDelegate.self)) called")

        self.window = setupWindow()
        return true
    }
    /// Getting the Window with Root view controller
    private func setupWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        if authManager.isSignedIn {
          AuthManager.shared.refreshIfNeeded(completion: nil)
            window.rootViewController = TabBarViewController()
        } else {
            let welcomeViewController = WelcomeViewController()
            welcomeViewController.navigationItem.largeTitleDisplayMode = .always
            let navigationController = UINavigationController(rootViewController: welcomeViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            window.rootViewController = navigationController
        }
        window.makeKeyAndVisible()
        
      return window
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
