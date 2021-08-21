//
//  VegetableListScreen.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import SwiftUI


struct VegetableListScreen: View {
  
  @StateObject private var vegetableListVM = VegetableListViewModel()
  
    var body: some View {
      VStack {
        List {
          ForEach(vegetableListVM.vegetables, id: \.id) { vegetable in
            VegetableCell(vegetable: vegetable)
          }
        }
      }
      .listStyle(.plain)
      .task { ///This `task` added into iOS 13 to perform any async call which you wait and get a callback
        await vegetableListVM.getAll()
      }
      .navigationTitle("Green Garden")
      .embedInNavigationView()
    }
}

struct VegetableCell: View {
  
  let vegetable: VegetableViewModel
  
  var body: some View {
    HStack {
      //In iOS13 Apple they have introduced AsyncImage Framework helper to load image using url
      AsyncImage(url: vegetable.thumbnailUrl) { image in
        image
          .resizable()
          .frame(maxWidth: 75, maxHeight: 75)
      } placeholder: {
        ProgressView()
      }
      Text(vegetable.name)
    }
  }
}


struct VegetableListScreen_Previews: PreviewProvider {
    static var previews: some View {
      VegetableListScreen()
    }
}
