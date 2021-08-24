//
//  AboutUs.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import SwiftUI

struct DescriptionView: View {
  
  let heading: String
  let content: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(heading)
        .font(.headline)
      Text(content)
        .fixedSize(horizontal: false, vertical: false)
    }
  }
  
}

struct DescriptionView_Previews: PreviewProvider {
  static var previews: some View {
    DescriptionView(heading: "Sowing", content: "\r\nEarly autumn is the best month to plant carrot seeds. Find a soft ground to sow the seeds. Pour a small glass of water between all of the seeds without washing away the dirt (This step should be performed every day).")
  }
}
