//
//  ButtonView.swift
//  Calculator
//
//  Created by BKS-GGS on 30/08/21.
//

import SwiftUI

struct ButtonView: View {
  @Binding var title: String
  @Binding var value: String
  
  var body: some View {
    Button(title) {
      value = title
    }
    .foregroundColor(.black)
    .font(Font.system(size: 25, weight: .semibold))
    .frame(width: 50, height: 50)
    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    .border(Color.black, width: 2)
  }
}

struct ButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonView(title: .constant("0"), value: .constant("0"))
  }
}
