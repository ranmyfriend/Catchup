//
//  TestingAppDelegate.swift
//  AppLaunchTests
//
//  Created by Ranjit on 14/03/21.
//

import Foundation
import UIKit

//The @objc annotation ensures that the class name is exposed to the runtime with the exact name that the code inmain.swift is checking for.

/*
 GOAL 2: How to bypass the Main Scene delegate with test scene delegate. through this customised scene configuration we can do this.
 let sessionConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
 sessionConfiguration.delegateClass = TestingSceneDelegate.self
 return sessionConfiguration
 */
@objc(TestingAppDelegate)
final class TestingAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(">> TEST AppDelegate Called")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        let sessionConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sessionConfiguration.delegateClass = TestingSceneDelegate.self
        return sessionConfiguration
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

