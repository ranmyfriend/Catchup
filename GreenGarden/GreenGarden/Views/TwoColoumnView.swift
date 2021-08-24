//
//  AboutUs.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import SwiftUI

/// Generic view
struct TwoColoumnView: View {
  
  let left: String
  let right: String
  
  var body: some View {
    HStack {
      Text(left)
      Spacer()
      Text(right)
    }
  }
  
}

struct TwoColoumnView_Previews: PreviewProvider {
  static var previews: some View {
    TwoColoumnView(left: "Left", right: "Right")
  }
}
