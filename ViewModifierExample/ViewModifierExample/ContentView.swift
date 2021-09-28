//
//  ContentView.swift
//  ViewModifierExample
//
//  Created by BKS-GGS on 28/09/21.
//

import SwiftUI

/*
 ViewModifier is kind of common behaviour are needed for more than one view. like rounded corner button and shadown button. We can create our viewModifier and supply it to via extension View.
 */

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        Color.pink
            .frame(width: 300, height: 300)
            .watermarked(with: "Hello Ranjith!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
