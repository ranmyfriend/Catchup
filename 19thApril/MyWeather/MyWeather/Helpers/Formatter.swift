//
//  Formatter.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import Foundation

let dayFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd"
  return formatter
}()

let monthFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMMM"
  return formatter
}()
