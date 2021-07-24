//
//  AlbumViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 24/07/21.
//

import UIKit

class AlbumViewController: UIViewController {

 private let album: Album
  
  init(album: Album) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      self.title = album.name
      view.backgroundColor = .systemBackground
      
      self.fetchAlbumDetails()
    }
  
  private func fetchAlbumDetails() {
    APICaller.shared.getAlbumDetails(for: self.album) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let value): break
        case .failure(let error): break
        }
      }
    }
  }
    
}
