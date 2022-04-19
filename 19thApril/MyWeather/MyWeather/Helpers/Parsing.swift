//
//  Parsing.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, WeatherError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            WeatherError.parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
