//
//  PlayerViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

protocol PlayerViewControllerDelegate: AnyObject {
  func didTapPlayPause()
  func didTapForward()
  func didTapBackward()
  func didSlideSlider(value: Float)
}

class PlayerViewController: UIViewController {
  
  weak var dataSource: PlayerDataSource?
  weak var delegate: PlayerViewControllerDelegate?
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
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
    configureDataSource()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
    controlsView.frame = CGRect(x: 10, y: imageView.bottom+10, width: view.width-20, height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
  }
  
  func configureDataSource() {
    imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
    controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
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
  
  func refreshUI() {
    configureDataSource()
  }
  
}

extension PlayerViewController: PlayerControlsViewDelegate {
  
  func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
    delegate?.didTapPlayPause()
  }
  
  func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
    delegate?.didTapForward()
  }
  
  func playerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
    delegate?.didTapBackward()
  }
  
  func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
    delegate?.didSlideSlider(value: value)
  }
}
