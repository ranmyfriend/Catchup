//
//  ContentViewModel.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject, Identifiable {
    
    @Published var city = ""
    @Published var dataSource: [DailyWeatherRowViewModel] = []
    
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetcher, scheduler: DispatchQueue = .init(label: "ContentViewModel")) {
        self.weatherFetcher = weatherFetcher
        
        $city
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchWeather(forCity:))
            .store(in: &disposables)
    }
    
    
    func fetchWeather(forCity city: String) {
        weatherFetcher.weeklyWeatherForecast(forCity: city)
            .map { response in
                response.list.map(DailyWeatherRowViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
        /* REFERENCE:
         let myRange = (0...3)
         cancellable = myRange.publisher
             .sink(receiveCompletion: { print ("completion: \($0)") },
                   receiveValue: { print ("value: \($0)") })

         // Prints:
         //  value: 0
         //  value: 1
         //  value: 2
         //  value: 3
         //  completion: finished
         */
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                
                switch value {
                case .failure:
                    self.dataSource = []
                case .finished: break
                }
            }, receiveValue: {[weak self] forecast in
                guard let self = self else { return}
                self.dataSource = forecast
            })
            .store(in: &disposables)
    }
}

