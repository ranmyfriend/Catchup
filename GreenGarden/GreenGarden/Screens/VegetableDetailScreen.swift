//
//  MainScreen.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import SwiftUI

//CaseIterable it means we can iterate the enum
enum VegetableInfoOptions: CaseIterable {
  case about
  case companions
  case problems
}

extension VegetableInfoOptions {

  var title: String {
    switch self {
    case .about: return "About"
    case .companions: return "Companions"
    case .problems: return "Problems"
    }
  }
  
}

struct VegetableDetailScreen: View {
  
  let vegetable: VegetableViewModel
  
  @State private var selection: VegetableInfoOptions = .about
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
       
        Picker("Select", selection: $selection) {
          ForEach(VegetableInfoOptions.allCases, id:\.self) { info in
            Text(info.title).tag(info)
          }
        }.pickerStyle(.segmented)
        
        switch selection {
        case .about:
          Text("About Us")
        case .companions:
          Text("Companions")
        case .problems:
          Text("Problems")
        }
        
      }
    }
  }
}

struct VegetableDetailScreen_Previews: PreviewProvider {
  static var previews: some View {
    VegetableDetailScreen(vegetable: VegetableViewModel.default())
  }
}
