//
//  ContentView.swift
//  Calculator
//
//  Created by BKS-GGS on 30/08/21.
//

import SwiftUI

struct Number {
  let title: String
  let value: String
}

struct ContentView: View {
  @State var input: String = "0"
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        TextField("0", text: $input)
          .font(Font.system(size: 25, weight: .semibold))
          .frame(width: .infinity, height: 55)
          .foregroundColor(.white)
          .background(Color.gray)
          .multilineTextAlignment(.trailing)
          
        Spacer(minLength: 25)
        
        HStack {
          ButtonView(title: .constant("7"))
          ButtonView(title: .constant("8"))
          ButtonView(title: .constant("9"))
          ButtonView(title: .constant("+"))
        }
        HStack {
          ButtonView(title: .constant("4"))
          ButtonView(title: .constant("5"))
          ButtonView(title: .constant("2"))
          ButtonView(title: .constant("-"))
        }
        HStack {
          ButtonView(title: .constant("1"))
          ButtonView(title: .constant("3"))
          ButtonView(title: .constant("2"))
          ButtonView(title: .constant("*"))
        }
        HStack {
          ButtonView(title: .constant("/"))
          ButtonView(title: .constant("0"))
          ButtonView(title: .constant("."))
          ButtonView(title: .constant("="))
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
