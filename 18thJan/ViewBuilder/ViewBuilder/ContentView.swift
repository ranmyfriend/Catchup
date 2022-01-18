//
//  ContentView.swift
//  ViewBuilder
//
//  Created by BKS-GGS on 18/01/22.
//

import SwiftUI

// Link: https://swiftwithmajid.com/2019/12/18/the-power-of-viewbuilder-in-swiftui/

struct ContentView: View {
    let condition = true
    
    @ViewBuilder
    var body: some View {
        if condition {
            Text("Text only")
        } else {
            Text("Text with background color")
                .background(Color.yellow)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
