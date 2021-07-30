//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by BKS-GGS on 30/07/21.
//

import Foundation

struct AllCategoriesResponse: Codable {
  let categories: Categories
}

struct Categories: Codable {
  let items: [Category]
}

struct Category: Codable {
  let id: String
  let name: String
  let icons: [APIImage]
}
