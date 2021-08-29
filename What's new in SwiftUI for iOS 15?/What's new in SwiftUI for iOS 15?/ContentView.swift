//
//  ContentView.swift
//  What's new in SwiftUI for iOS 15?
//
//  Created by BKS-GGS on 29/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      List(1..<51) {
        Text("\($0)")
      }
      .listStyle(.sidebar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
