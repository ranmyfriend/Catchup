//
//  WeatherError.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import Foundation

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}
