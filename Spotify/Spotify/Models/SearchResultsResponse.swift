//
//  SearchResultsResponse.swift
//  Spotify
//
//  Created by BKS-GGS on 01/08/21.
//

import Foundation

struct SearchResultsResponse: Codable {
  let albums: SearchAlbumResponse
  let artists: SearchArtistsResponse
  let playlists: SearchPlaylistsResponse
  let tracks: SearchTracksResponse
}

struct SearchAlbumResponse: Codable {
  let items: [Album]
}

struct SearchArtistsResponse: Codable {
  let items: [Artist]
}

struct SearchPlaylistsResponse: Codable {
  let items: [Playlist]
}

struct SearchTracksResponse: Codable {
  let items: [AudioTrack]
}
