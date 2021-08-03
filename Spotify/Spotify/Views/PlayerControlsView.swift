//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by BKS-GGS on 03/08/21.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
  func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
  func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
  func playerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView)
}

final class PlayerControlsView: UIView {
  
  weak var delegate: PlayerControlsViewDelegate?
  
  private let volumeSlider: UISlider = {
    let slider = UISlider()
    slider.value = 0.5
    return slider
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "This is my song"
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Drake (Feat)"
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = .secondaryLabel
    return label
  }()
  
  private let backButton: UIButton = {
    let button = UIButton()
    button.tintColor = .label
    let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    button.setImage(image, for: .normal)
    return button
  }()
  
  private let forwardButton: UIButton = {
    let button = UIButton()
    button.tintColor = .label
    let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    button.setImage(image, for: .normal)
    return button
  }()
  
  private let playPauseButton: UIButton = {
    let button = UIButton()
    button.tintColor = .label
    let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    button.setImage(image, for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    addSubview(nameLabel)
    addSubview(subtitleLabel)
    addSubview(volumeSlider)
    addSubview(backButton)
    addSubview(forwardButton)
    addSubview(playPauseButton)
    
    backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
    forwardButton.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
    
    clipsToBounds = true
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
    subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
    volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44)
    
    let buttonSize: CGFloat = 60
    playPauseButton.frame = CGRect(x: (width - buttonSize)/2, y: volumeSlider.bottom + 30, width: buttonSize, height: buttonSize)
    backButton.frame = CGRect(x: playPauseButton.left - 80 - buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
    forwardButton.frame = CGRect(x: playPauseButton.right + 80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
  }
  
  @objc func didTapBack() {
    delegate?.playerControlsViewDidTapBackwardButton(self)
  }
  
  @objc func didTapPlayPause() {
    delegate?.playerControlsViewDidTapPlayPause(self)
  }
  
  @objc func didTapForward() {
    delegate?.playerControlsViewDidTapForwardButton(self)
  }
  
}
