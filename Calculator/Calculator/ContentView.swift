//
//  ContentView.swift
//  Calculator
//
//  Created by BKS-GGS on 30/08/21.
//

import SwiftUI

//ButtonView holds this struct
struct Number {
  var title: String //"0"
  var value: Int //0
  var isSymbol: Bool // false
}

struct ContentView: View {
  @State var input: String = "0"
  
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          TextField("", text: $input)
            .font(Font.system(size: 25, weight: .semibold))
            .frame(height: 55)
            .foregroundColor(.white)
            .background(Color.gray)
            .multilineTextAlignment(.trailing)
            .accessibility(identifier: "output-textfield")
        }
        .padding([.leading, .trailing], 20)
         
        Spacer(minLength: 20)
        
        VStack {
          
          HStack {
            ButtonView(title: .constant("7"), value: $input)
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

        Spacer(minLength: 20)
        
        HStack {
          Button("CLEAR") {
            input = "0"
          }
          .frame(height: 50)
          .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
          .border(Color.black, width: 1)
        }
        .padding([.leading,.trailing], 20)
      }
      .accessibility(identifier: "primary-vstack")
      .padding([.leading,.trailing], 20)

    }.accessibility(identifier: "parent-scrollview")
    .navigationTitle("CALCULATOR")
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .embedInNavigationView()
  }
}
