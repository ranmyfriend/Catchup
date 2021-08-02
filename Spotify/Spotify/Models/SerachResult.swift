//
//  SerachResult.swift
//  Spotify
//
//  Created by BKS-GGS on 02/08/21.
//

import Foundation

enum SearchResult {
  case artist(model: Artist)
  case album(model: Album)
  case track(model: AudioTrack)
  case playlist(model: Playlist)
}
