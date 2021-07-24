//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by BKS-GGS on 24/07/21.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
  let description: String
  let external_urls: [String: String]
  let id: String
  let images: [APIImage]
  let name: String
  let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
  let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
  let track: AudioTrack
}
