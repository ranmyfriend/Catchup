//
//  ContentView.swift
//  WristNews WatchKit Extension
//
//  Created by BKS-GGS on 01/04/22.
//

import SwiftUI

// Tutorial Link: https://medium.com/macoclock/making-a-watchos-app-with-swiftui-from-scratch-with-data-fetching-68981acf615f

struct ContentView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Text("Wrist News!")
                .font(.title)
                .fontWeight(.thin)
            
            Text("Daily news, delivered on your wrist.")
                .fontWeight(.thin)
            
            Spacer()
            NavigationLink(destination: ArticlesView()) {
                Text("Start")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
