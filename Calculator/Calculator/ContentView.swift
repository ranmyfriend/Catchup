//
//  ContentView.swift
//  Calculator
//
//  Created by BKS-GGS on 30/08/21.
//

import SwiftUI

struct Number {
  var value: String
}

struct ContentView: View {
  @State var input: String = "0"
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        TextField("", text: $input)
          .font(Font.system(size: 25, weight: .semibold))
          .frame(width: .infinity, height: 55)
          .foregroundColor(.white)
          .background(Color.gray)
          .multilineTextAlignment(.trailing)
        
        Spacer(minLength: 25)
        
        HStack {
          ButtonView(title: .constant("7"), value: $input)
            .accessibility(label: Text("7 number"))
            .accessibility(value: Text("7"))
          ButtonView(title: .constant("8"), value: $input)
          ButtonView(title: .constant("9"), value: $input)
          ButtonView(title: .constant("+"), value: $input)
        }
        HStack {
          ButtonView(title: .constant("4"), value: $input)
          ButtonView(title: .constant("5"), value: $input)
          ButtonView(title: .constant("6"), value: $input)
          ButtonView(title: .constant("-"), value: $input)
        }
        HStack {
          ButtonView(title: .constant("1"), value: $input)
          ButtonView(title: .constant("2"), value: $input)
          ButtonView(title: .constant("3"), value: $input)
          ButtonView(title: .constant("*"), value: $input)
        }
        HStack {
          ButtonView(title: .constant("/"), value: $input)
          ButtonView(title: .constant("0"), value: $input)
          ButtonView(title: .constant("."), value: $input)
          ButtonView(title: .constant("="), value: $input)
        }
      }
      .padding([.leading,.trailing], 20)
    }
    .navigationTitle("CALCULATOR")
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .embedInNavigationView()
  }
}
