//
//  Constants.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import Foundation
import SwiftUI

struct Constants {
  struct Urls {
    static let getAllVegetables = URL(string: "http://highoncoding.com/vegetable/getcatalog")
  }
  
  struct Colors {
    static let lightGreyColor = Color(uiColor: .lightGray.withAlphaComponent(0.1))
    static let lightBlueColor = Color(#colorLiteral(red:0.7846713662, green: 0.8902227283, blue: 0.8900751472, alpha: 1))
  }
}
