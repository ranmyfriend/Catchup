//
//  PlayerViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class PlayerViewController: UIViewController {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .systemBlue
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let controlsView = PlayerControlsView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(imageView)
    view.addSubview(controlsView)
    controlsView.delegate = self
    configureBarButtons()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
    controlsView.frame = CGRect(x: 10, y: imageView.bottom+10, width: view.width-20, height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
  }
  
  private func configureBarButtons() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
  }
  
  @objc func didTapClose() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func didTapAction() {
    
  }
  
}

extension PlayerViewController: PlayerControlsViewDelegate {
  func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
    
  }
  
  func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
    
  }
  
  func playerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
    
  }
}
