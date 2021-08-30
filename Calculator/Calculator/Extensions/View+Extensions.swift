//
//  View+Extensions.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//


import SwiftUI

extension View {
  
  ///This helper function which enables all views can embed into navigationView
  func embedInNavigationView() -> some View {
    NavigationView { self }
  }
}





