//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by BKS-GGS on 07/08/21.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
  func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
  func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
  
  enum State {
    case playlist
    case album
  }
  
  var state: State = .playlist
  weak var delegate: LibraryToggleViewDelegate?
  
  private let playlistButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.setTitle("Playlists", for: .normal)
    return button
  }()
  
  private let albumsButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.setTitle("Albums", for: .normal)
    return button
  }()
  
  private let indicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGreen
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 4
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(playlistButton)
    addSubview(albumsButton)
    addSubview(indicatorView)
    
    playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
    albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
    albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
    
    adjustLayoutIndicatorFrame()
  }
  
  @objc private func didTapPlaylists() {
    state = .playlist
    delegate?.libraryToggleViewDidTapPlaylists(self)
    UIView.animate(withDuration: 0.2) { [weak self] in
      self?.adjustLayoutIndicatorFrame()
    }
  }
  
  @objc private func didTapAlbums() {
    state = .album
    UIView.animate(withDuration: 0.2) { [weak self] in
      self?.adjustLayoutIndicatorFrame()
    }
    delegate?.libraryToggleViewDidTapAlbums(self)
  }
  
  private func adjustLayoutIndicatorFrame() {
    switch state {
    case .playlist:
      indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
    case .album:
      indicatorView.frame = CGRect(x: playlistButton.width, y: albumsButton.bottom, width: 100, height: 3)
    }
  }
  
  func update(for state: State) {
    self.state = state
    UIView.animate(withDuration: 0.2) { [weak self] in
      self?.adjustLayoutIndicatorFrame()
    }
  }

}
