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
  
  var seedDepth: String {
    vegetable.seedDepth
  }
  
  var growingSoilTemperature: String {
    vegetable.growingSoilTemp
  }
  
  var sowingDescription: String {
    vegetable.sowingDescription
  }
  
  var growingDescription: String {
    vegetable.growingDescription
  }
  
}

extension VegetableViewModel {
  
  static func `default`() -> VegetableViewModel {
    let vegetable = Vegetable(vegetableId: 1, name: "Carrot", description: "The carrot is a root vegetable, usually orange in colour, though purple, red, white, and yellow varieties exist", thumbnailImage: "http://www.highoncoding.com/VegetableImages/carrots.png", seedDepth: "1/4-1/2", growingSoilTemp: "60-65 F (16-18 C)", sowingDescription: "\r\nEarly autumn is the best month to plant carrot seeds. Find a soft ground to sow the seeds. Pour a small glass of water between all of the seeds without washing away the dirt (This step should be performed every day).", growingDescription: "The seeds will start to sprout in couple of weeks. When watering the seeds make sure to avoid getting the leaves wet. The wetting of leaves can result in burning holes into the leaves from the sun.")
    return VegetableViewModel(vegetable: vegetable)
  }
  
}
