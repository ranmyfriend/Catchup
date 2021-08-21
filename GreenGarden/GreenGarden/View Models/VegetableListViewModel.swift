//
//  VegetableListViewModel.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import Foundation

///in iOS 13 onwards, Usage of putting @MainActor in above the class is all of the properties can be accessed in main thread. same goes to function as well.
///You dont have to do DispatchQueue.main.Async and al.
@MainActor
class VegetableListViewModel: ObservableObject {
  
  @Published var vegetables: [VegetableViewModel] = []
  
  func getAll() async {
    
    do {
        let vegetables = try await Webservice().getAllVegetables(url: Constants.Urls.getAllVegetables)
      self.vegetables = vegetables.map(VegetableViewModel.init)
    } catch {
      print(error)
    }
    
  }
  
}

struct VegetableViewModel {
  
  fileprivate let vegetable: Vegetable
  
  var id: Int {
    vegetable.vegetableId
  }
  
  var name: String {
    vegetable.name
  }
  
  var description: String {
    vegetable.description
  }
  
  var thumbnailUrl: URL? {
    URL(string: vegetable.thumbnailImage)
  }
  
}
