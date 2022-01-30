//
//  ContentView.swift
//  CircleAnimation
//
//  Created by BKS-GGS on 30/01/22.
//

import SwiftUI

/*
 Topic: SwiftUI: Circle Fill Animation (2021, Xcode 12, SwiftUI 2.0) - iOS Development
 Link: https://www.youtube.com/watch?v=6tDTMVxn5us
 */

struct ContentView: View {
    @State private var fill: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 11/255, green: 15/255, blue: 128/255, alpha: 1.0))
            
            ZStack {
                // Track circle
                Circle()
                    .stroke(Color.white.opacity(0.3), style: StrokeStyle(lineWidth: 30))
                
                // Animation circle
                Circle()
                    .trim(from: 0, to: self.fill)
                    .stroke(Color.yellow, style: StrokeStyle(lineWidth: 30))
                    .rotationEffect(Angle(degrees: -90))
                    .animation(Animation.linear(duration: 0.3))
                
                Text("$\(Int(self.fill * 100.0))")
                    .foregroundColor(.white)
                    .font(.system(size: 52))
            }
            .padding(50)
        }
        .onTapGesture {
            
            for x in 0...100 {
                DispatchQueue.main.asyncAfter(deadline: .now()+TimeInterval(x/15)) {
                    self.fill += 0.01
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
