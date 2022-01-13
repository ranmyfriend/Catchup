//
//  ContentView.swift
//  RecipeSaver
//
//  Created by BKS-GGS on 07/01/22.
//

import SwiftUI

/*
 Topic: Build a Recipe App from scratch with SwiftUI - Part 1
 Youtube Link: https://www.youtube.com/watch?v=uSanD_pFwis
 */

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
    }
}
