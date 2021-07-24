//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class PlaylistViewController: UIViewController {

  private let playlist: Playlist
   
   init(playlist: Playlist) {
     self.playlist = playlist
     super.init(nibName: nil, bundle: nil)
   }
   required init?(coder: NSCoder) {
     fatalError()
   }
     override func viewDidLoad() {
         super.viewDidLoad()
       self.title = playlist.name
       view.backgroundColor = .systemBackground
      
      self.fetchPlaylistDetails()
     }
  
  private func fetchPlaylistDetails() {
    APICaller.shared.getPlaylistDetails(for: self.playlist) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let value): break
        case .failure(let error): break
        }
      }
    }
  }
  
}
