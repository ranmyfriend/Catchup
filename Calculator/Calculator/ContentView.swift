//
//  ContentView.swift
//  Calculator
//
//  Created by BKS-GGS on 30/08/21.
//

import SwiftUI

//BView holds this struct
struct Number {
  var title: String //"0"
  var value: Int //0
  var isSymbol: Bool // false
}

struct ContentView: View {
  @State var input: String = "0"
  
  var body: some View {
    ScrollView {
      Spacer(minLength: 20)
      VStack {
        HStack {
          ZStack {
            RoundedRectangle(cornerRadius: 2.0)
              .stroke()
           
            HStack {
              Spacer()
              Text(input)
                .font(Font.system(size: 21, weight: .semibold))
                .frame(height: 50)
                .accessibility(identifier: "output-textfield")
            }
            .padding(.horizontal, 5)
          }
          .foregroundColor(.blue)
          
        }
         
        Spacer(minLength: 20)
        
        VStack {
          
          HStack {
            BView(title: .constant("7"), value: $input)
            BView(title: .constant("8"), value: $input)
            BView(title: .constant("9"), value: $input)
            BView(title: .constant("+"), value: $input)
          }

          HStack {
            BView(title: .constant("4"), value: $input)
            BView(title: .constant("5"), value: $input)
            BView(title: .constant("6"), value: $input)
            BView(title: .constant("-"), value: $input)
          }
          
          HStack {
            BView(title: .constant("1"), value: $input)
            BView(title: .constant("2"), value: $input)
            BView(title: .constant("3"), value: $input)
            BView(title: .constant("*"), value: $input)
          }

          HStack {
            BView(title: .constant("/"), value: $input)
            BView(title: .constant("0"), value: $input)
            BView(title: .constant("."), value: $input)
            BView(title: .constant("="), value: $input)
          }
        }
        
        Spacer(minLength: 20)
        
        HStack {
          ZStack {
            RoundedRectangle(cornerRadius: 2.0)
              .stroke()
            HStack {
              Spacer()
              Text("CLEAR")
                .font(.system(size: 21))
            }
            .padding(.horizontal, 8)
          }
          .foregroundColor(.blue)
          .onTapGesture {
            input = "0"
          }.frame(height: 50)
          
        }

      }
      .accessibility(identifier: "primary-vstack")
      .padding([.leading,.trailing], 50)

    }.accessibility(identifier: "parent-scrollview")
    .navigationTitle("CALCULATOR")
  }
  
}


struct BView: View {
  @Binding var title: String
  @Binding var value: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 2.0)
        .stroke()
      Text(title)
        .font(.title)
    }
    .foregroundColor(.blue)
    .onTapGesture {
      value += title
    }
    .frame(width: 50, height: 50)
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
//    BView(title: .constant("7"), value: .constant("7"))
    ContentView()
      .embedInNavigationView()
  }
}
