//
//  ContentView.swift
//  HoverEffect
//
//  Created by BKS-GGS on 12/04/23.
//

import SwiftUI

struct HoverEffectExample: View {
    var body: some View {
        VStack(spacing: 50) {
            Circle()
                .fill(.pink)
                .frame(width: 100, height: 100)
                .hoverEffect(.lift)
                
            Circle()
                .fill(.orange)
                .frame(width: 100, height: 100)
                .hoverEffect(.lift)
            
            Circle()
                .fill(.green)
                .frame(width: 100, height: 100)
                .hoverEffect(.lift)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HoverEffectExample()
    }
}
