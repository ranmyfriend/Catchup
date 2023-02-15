//
//  TabView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 22/04/22.
//

import SwiftUI

enum TabBarItem {
    case home
    case search
    case library
}

struct ContentView: View {
    @EnvironmentObject private var authentication: AuthViewModel

    var body: some View {
        tabBarView()
    }
    
    @ViewBuilder private func tabBarView() -> some View {
        TabView(selection: $authentication.selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(TabBarItem.home)
        }
        .onAppear {
            let appearance = UITabBarAppearance()

            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.secondarySystemBackground

            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
//        .onChange(of: appState) { newValue in
//            switch newValue {
//            case .active:
//                performSync()
//            case .background, .inactive:
//                break
//            }
//        }
//        .onReceive(authentication.$technicianProfile) { _ in
//            performSync()
//        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
