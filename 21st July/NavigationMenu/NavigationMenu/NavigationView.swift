//
//  NavigationView.swift
//  NavigationMenu
//
//  Created by BKS-GGS on 21/07/21.
//

import SwiftUI

struct NavigationView: View {
  @Namespace private var menuItemTransition
  @Binding var selectedIndex: Int
  let menuItems: [String]
  
    var body: some View {
      HStack {
        Spacer()
        
        ForEach(menuItems.indices) { index in
          
          if index == selectedIndex {
            Text(menuItems[index])
              .padding(.horizontal)
              .padding(.vertical, 4)
              .background(Capsule().foregroundColor(Color.purple))
              .foregroundColor(.white)
              .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
          } else {
            Text(menuItems[index])
              .padding(.horizontal)
              .padding(.vertical, 4)
              .background(Capsule().foregroundColor(Color(.systemGray5)))
              .foregroundColor(.white)
              .onTapGesture {
                selectedIndex = index
              }
          }
          Spacer()
        }
        
      }
      .frame(minWidth: 0, maxWidth: .infinity)
      .padding()
      .animation(.easeInOut, value: selectedIndex)
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView(selectedIndex: .constant(0), menuItems: ["Travel", "Aeroplane", "Architecture"])
    }
}
