//
//  MyWeatherApp.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import SwiftUI

@main
struct MyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let fetcher = WeatherFetcher()
            let viewModel = ContentViewModel(weatherFetcher: fetcher)
            ContentView(viewModel: viewModel)
        }
    }
}
