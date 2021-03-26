//
//  TestAppDelegate.swift
//  SpotifyTests
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit


@objc(TestAppDelegate)
final class TestAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(">> \(String(describing: TestAppDelegate.self)) called")
        self.window = setupWindow()
        
        return true
    }
    
    /// Getting the Window with Root view controller
    private func setupWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TestRootViewController()
        window.makeKeyAndVisible()
        return window
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sessionConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sessionConfiguration.delegateClass = TestSceneDelegate.self
        return sessionConfiguration
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
