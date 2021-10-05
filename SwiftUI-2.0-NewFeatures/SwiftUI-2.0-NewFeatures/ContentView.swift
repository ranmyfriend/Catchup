//
//  ContentView.swift
//  SwiftUI-2.0-NewFeatures
//
//  Created by BKS-GGS on 04/10/21.
//

import SwiftUI

/// Grid View vs Collection View

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    //Grid item specifies number of rows and columns in grid
    var columns: [GridItem] = [
        // First only one row..
        
        // here you can also specify the minimum and maximum size
        
        //when you want new column you must specify it here.
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(0...8, id: \.self) { img in
                    Image("p\(img)")
                        .resizable()
                        .frame(width: 200)
                }
            }
        }
    }
}
