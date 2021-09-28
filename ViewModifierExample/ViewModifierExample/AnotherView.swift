//
//  AnotherView.swift
//  ViewModifierExample
//
//  Created by BKS-GGS on 28/09/21.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(Color.blue)
    }
}

/// You can apply ``View/modifier(_:)`` directly to a view, but a more common
/// and idiomatic approach uses ``View/modifier(_:)`` to define an extension to
/// ``View`` itself that incorporates the view modifier:

extension View {
    func borderedCaption() -> some View {
        modifier(BorderedCaption())
    }
}

struct AnotherView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .borderedCaption()
    }
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherView()
    }
}
