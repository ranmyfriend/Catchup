//
//  ContentView.swift
//  NavigationMenu
//
//  Created by BKS-GGS on 21/07/21.
//

import SwiftUI

/*
 Concept: Build Navigation Menu with TabBar
 Link: https://www.appcoda.com/animated-navigation-menu/
 */

struct ContentView: View {
  @State var selectedIndex = 0
  let menuItems = ["Travel", "Film", "Food & Drink"]
  
    var body: some View {
      TabView(selection: $selectedIndex) {
          
        ForEach(menuItems.indices) { index in
          Text(menuItems[index])
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.green)
            .foregroundColor(Color.white)
            .font(.system(size: 50, weight: .heavy, design: .rounded))
            .tag(index)
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      .ignoresSafeArea()
      .overlay(
        NavigationView(selectedIndex: $selectedIndex, menuItems: menuItems)
        , alignment: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
