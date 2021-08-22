//
//  GreenGardenApp.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//


/*
 Author: https://www.youtube.com/watch?v=6-thiPMKhFo
 Version: Xcode 13.0 beta & iOS 15
 */

import SwiftUI

@main
struct GreenGardenApp: App {
  
  init() {
    setupTheme()
  }
  
  private func setupTheme() {
    UINavigationBar.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.1804504693, green: 0.8003295064, blue: 0.4435202479, alpha: 1))
    let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    UINavigationBar.appearance().titleTextAttributes = textAttributes
    UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
  }
  
    var body: some Scene {
        WindowGroup {
          MainScreen()
        }
    }
}
