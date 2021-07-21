//
//  Artist.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation

struct Artist: Codable {
  let id: String
  let name: String
  let type: String
  let external_urls: [String: String]
}
