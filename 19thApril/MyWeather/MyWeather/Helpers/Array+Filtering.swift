//
//  Array+Filtering.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import Foundation

/// Taken from here: https://stackoverflow.com/a/46354989/491239
public extension Array where Element: Hashable {
  static func removeDuplicates(_ elements: [Element]) -> [Element] {
    var seen = Set<Element>()
    return elements.filter{ seen.insert($0).inserted }
  }
}
