//
//  ContentView.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
      NavigationView {
        List {
          searchField
          
          if viewModel.dataSource.isEmpty {
            emptySection
          } else {
            forecastSection
          }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Weather ⛅️")
      }
    }
}

extension ContentView {
    var searchField: some View {
        HStack {
            TextField("e.g. Chennai", text: $viewModel.city)
        }
    }
    
    var forecastSection: some View {
        Section {
//            ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
            ForEach(viewModel.dataSource) { dailyWeatherRowViewModel in
                DailyWeatherRow(viewModel: dailyWeatherRowViewModel)
            }
        }
    }
    
    var emptySection: some View {
      Section {
        Text("No results")
          .foregroundColor(.gray)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let fetcher = WeatherFetcher()
        let viewModel = ContentViewModel(weatherFetcher: fetcher)
        ContentView(viewModel: viewModel)
    }
}
