//
//  ContentView.swift
//  DynamicProperty
//
//  Created by BKS-GGS on 24/02/23.
//

import SwiftUI

struct ContentView: View {
    @UpperCased var name = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(name)")
            TextField("Enter a name", text: $name)
        }
        .padding()
    }
}

@propertyWrapper
struct UpperCased: DynamicProperty {
    @State var wrappedValue: String
    
    var projectedValue: Binding<String> {
        Binding (
            get: {
                wrappedValue.uppercased()
            },
            set: {
                wrappedValue = $0.uppercased()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
