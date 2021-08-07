//
//  LibraryViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class LibraryViewController: UIViewController {
  
  private let playlistViewController = LibraryPlaylistsViewController()
  private let albumViewController = LibraryAlbumViewController()
  
  private let scrollview: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isPagingEnabled = true
    return scrollView
  }()
  
  private let toggleView = LibraryToggleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
      view.addSubview(toggleView)
      scrollview.delegate = self
      view.addSubview(scrollview)
      scrollview.contentSize = CGSize(width: view.width*2, height: scrollview.height)
      addChildren()
      toggleView.delegate = self
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    scrollview.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.width, height: view.height-view.safeAreaInsets.bottom-55)
    toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 55)
  }
  
  private func addChildren() {
    addChild(playlistViewController)
    scrollview.addSubview(playlistViewController.view)
    playlistViewController.view.frame = CGRect(x: 0, y: 0, width: scrollview.width, height: scrollview.height)
    playlistViewController.didMove(toParent: self)

    addChild(albumViewController)
    scrollview.addSubview(albumViewController.view)
    albumViewController.view.frame = CGRect(x: view.width, y: 0, width: scrollview.width, height: scrollview.height)
    albumViewController.didMove(toParent: self)
  }

}

extension LibraryViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollview.contentOffset.x >= (view.width-100) {
      toggleView.update(for: .album)
    } else {
      toggleView.update(for: .playlist)
    }
  }
}


extension LibraryViewController: LibraryToggleViewDelegate {
  func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
    scrollview.setContentOffset(.zero, animated: true)
  }
  
  func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
    scrollview.setContentOffset(CGPoint(x: view.width,y: 0), animated: true)
  }
  
}
