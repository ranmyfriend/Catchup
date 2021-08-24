//
//  AboutUs.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import SwiftUI

struct AboutUs: View {
  
  let vegetable: VegetableViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(vegetable.description)
        .fixedSize(horizontal: false, vertical: false)
      
      Text("Sowing")
        .font(.headline)
      
      VStack(spacing: 10) {
        TwoColoumnView(left: "Seed depth", right: vegetable.seedDepth)
        TwoColoumnView(left: "Germination soil temperature", right: vegetable.growingSoilTemperature)
        
        DescriptionView(heading: "Sowing",
                        content: vegetable.sowingDescription
        )
          .padding()
          .background(Constants.Colors.lightGreyColor)
          .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
          .foregroundColor(.black)
        
        DescriptionView(heading: "Growing",
                        content: vegetable.growingDescription
        )
          .padding()
          .background(Constants.Colors.lightBlueColor)
          .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
          .foregroundColor(.black)
      
        Spacer()
      }
    }
    .padding()
  }
  
}

struct AboutUs_Previews: PreviewProvider {
  static var previews: some View {
    AboutUs(vegetable: VegetableViewModel.default())
  }
}
