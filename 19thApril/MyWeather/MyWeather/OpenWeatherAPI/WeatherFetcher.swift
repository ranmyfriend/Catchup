//
//  WeatherFetcher.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import Foundation
import Combine

protocol WeatherFetchable {
    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse,WeatherError>
}

class WeatherFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension WeatherFetcher {
    struct OpenWeatherAPI {
      static let scheme = "https"
      static let host = "api.openweathermap.org"
      static let path = "/data/2.5"
      static let key = "f2000d471d0ef1cac009aef510d331b7"
    }
    
    func makeWeeklyForecastComponents(
      withCity city: String
    ) -> URLComponents {
      var components = URLComponents()
      components.scheme = OpenWeatherAPI.scheme
      components.host = OpenWeatherAPI.host
      components.path = OpenWeatherAPI.path + "/forecast"
      
      components.queryItems = [
        URLQueryItem(name: "q", value: city),
        URLQueryItem(name: "mode", value: "json"),
        URLQueryItem(name: "units", value: "metric"),
        URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
      ]
      
      return components
    }
}

extension WeatherFetcher: WeatherFetchable {
    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        forecast(with: makeWeeklyForecastComponents(withCity: city))
    }
    
    private func forecast<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                WeatherError.network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
