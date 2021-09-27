//
//  ContentView.swift
//  TaskApp
//
//  Created by BKS-GGS on 27/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        Home()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
