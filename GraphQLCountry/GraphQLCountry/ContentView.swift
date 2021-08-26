//
//  ContentView.swift
//  GraphQLCountry
//
//  Created by BKS-GGS on 25/08/21.
//

import SwiftUI

struct ContentView: View {
//  @State private var countries: [GetAllCountriesQuery.Data.Country] = []
  
    var body: some View {
      Text("Hello")
//      NavigationView {
//        VStack {
//          List(countries, id: \.code) { country in
//            Text(country.name)
//          }
//        }
//        .onAppear(perform: {
//          Network.shared.apollo.fetch(query: GetAllCountriesQuery()) { [self] result in
//            switch result {
//            case .success(let graphQLResult):
//              if let countries = graphQLResult.data?.countries {
//                DispatchQueue.main.async {
//                  self.countries = countries
//                }
//              }
//              print("success")
//            case .failure(let error):
//              print("error")
//            }
//          }
//        })
//        .navigationTitle("Countries")
//      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
