//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by BKS-GGS on 24/07/21.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
  func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
  static let identifier = "PlaylistHeaderCollectionReusableView"
  
  weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.numberOfLines = 0
    return label
  }()
  
  private let ownerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 18, weight: .light)
    return label
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(systemName: "photo")
    return imageView
  }()
  
  private let playAllButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .systemGreen
    let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
    button.setImage(image, for: .normal)
    button.tintColor = .white
    button.layer.cornerRadius = 30
    button.layer.masksToBounds = true
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    
    addSubview(imageView)
    addSubview(nameLabel)
    addSubview(descriptionLabel)
    addSubview(ownerLabel)
    addSubview(playAllButton)
    
    playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  @objc func didTapPlayAll() {
    delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let imageSize: CGFloat = height/1.8
    imageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
    nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width-20, height: 44)
    descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width-20, height: 44)
    ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width-20, height: 44)
    
    playAllButton.frame = CGRect(x: width-70, y: height-70, width: 60, height: 60)
  }
  
  func configure(with viewModel: PlaylistHeaderViewViewModel) {
    nameLabel.text = viewModel.name
    descriptionLabel.text = viewModel.description
    ownerLabel.text = viewModel.ownerName
    imageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
  }
}
