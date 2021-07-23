//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by BKS-GGS on 22/07/21.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
  static let identifier = "FeaturedPlaylistCollectionViewCell"
  
  private let playlistCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 4
    imageView.clipsToBounds = true
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let playlistNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  private let creatorNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .thin)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(playlistCoverImageView)
    contentView.addSubview(playlistNameLabel)
    contentView.clipsToBounds = true
    contentView.addSubview(creatorNameLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    creatorNameLabel.frame = CGRect(x: 3, y: contentView.height-44, width: contentView.width-6, height: 30)
    playlistNameLabel.frame = CGRect(x: 3, y: contentView.height-60, width: contentView.width-6, height: 30)
    let imageSize = contentView.height-70
    playlistCoverImageView.frame = CGRect(x: (contentView.width-imageSize)/2, y: 3, width: imageSize, height: imageSize)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    playlistNameLabel.text = nil
    creatorNameLabel.text = nil
    playlistCoverImageView.image = nil
  }
  
  func configure(with viewModel: FeaturedPlaylistCellViewModel) {
    playlistNameLabel.text = viewModel.name
    creatorNameLabel.text = viewModel.creatorName
    playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
  }
  
}
