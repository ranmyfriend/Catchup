//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by BKS-GGS on 19/08/21.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
  let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
  let added_at: String
  let album: Album
}
