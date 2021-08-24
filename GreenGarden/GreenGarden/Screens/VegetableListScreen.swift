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
            
            NavigationLink(destination: VegetableDetailScreen(vegetable: vegetable)) {
              VegetableCell(vegetable: vegetable)
                .background(Constants.Colors.lightGreyColor)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }
          }
          .listRowSeparator(.hidden)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Green Garden")
      .task { ///This `task` added into iOS 15 to perform any async call which you wait and get a callback
        await vegetableListVM.getAll()
      }
    }
}

struct VegetableCell: View {
  
  let vegetable: VegetableViewModel
  
  var body: some View {
    HStack {
      //In iOS15 Apple they have introduced AsyncImage Framework helper to load image using url
      AsyncImage(url: vegetable.thumbnailUrl) { image in
        image
          .resizable()
          .frame(maxWidth: 75, maxHeight: 75)
      } placeholder: {
        ProgressView()
      }
      Text(vegetable.name)
      Spacer() //This spacer moves the items are into leading side.
    }
    .padding(5)
    .frame(maxWidth: .infinity)
  }
}


struct VegetableListScreen_Previews: PreviewProvider {
    static var previews: some View {
      VegetableListScreen()
        .navigationTitle("Green Garden")
        .embedInNavigationView()
    }
}
