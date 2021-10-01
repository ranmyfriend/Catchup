//
//  ContentView.swift
//  SVG-to-SwiftUI
//
//  Created by BKS-GGS on 30/09/21.
//

import SwiftUI

/*
 SOURCE: https://quassummanus.github.io/SVG-to-SwiftUI/
 YOUTUBE: https://www.youtube.com/watch?v=zpG4uvLiYTU
 Note: instead of creating shapes from scratch we will be able to convert existing shape SVG(Scalable Vector Graphics) to SwiftUI Code. So we can easily create our own shapes in swiftUI to use.
 */

struct ContentView: View {
    var body: some View {
        ZStack {
            background
            
            VStack {
                TabView {
                    VStack {
                        ContentSubView()
                        TextGradientView()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
        }
    }
     
    var background: some View {
        Circle()
            .background(Color.blue)
            .ignoresSafeArea()
    }
}

struct ContentSubView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .foregroundColor(Color.white)
            .font(.largeTitle)
            .background(Color.pink)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct TextGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(stops: [.init(color: Color.red, location: 0),.init(color: Color.blue, location: 1)]), startPoint: UnitPoint(x: 1.001256, y: 1.0017556), endPoint: UnitPoint(x: -1.110234, y: 0))
            .frame(height: 50)
            .mask(Text("Hello World!")
                    .font(.largeTitle)
                    .bold())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
