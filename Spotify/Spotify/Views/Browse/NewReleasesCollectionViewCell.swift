//
//  NewReleasesCollectionViewCell.swift
//  Spotify
//
//  Created by BKS-GGS on 22/07/21.
//

import UIKit
import SDWebImage

class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
  
  private let albumCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let albumNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.numberOfLines = 0
    return label
  }()
  
  private let noOfTracksLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .thin)
    label.numberOfLines = 0
    return label
  }()
  
  
  private let artistNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .light)
    label.numberOfLines = 0
    return label
  }()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    contentView.addSubview(albumCoverImageView)
    contentView.addSubview(albumNameLabel)
    contentView.addSubview(noOfTracksLabel)
    contentView.clipsToBounds = true
    contentView.addSubview(artistNameLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let imageSize: CGFloat = contentView.height-10
    let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-imageSize-10, height: contentView.height-imageSize-10))
    albumNameLabel.sizeToFit()
    artistNameLabel.sizeToFit()
    noOfTracksLabel.sizeToFit()
    
    albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
    albumNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: 5, width: albumLabelSize.width, height: min(70, albumLabelSize.height))

    artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: albumNameLabel.bottom, width: contentView.width-albumCoverImageView.right-10, height: 30)

    noOfTracksLabel.frame = CGRect(x: albumCoverImageView.right+10, y: contentView.bottom-44, width: noOfTracksLabel.width, height: 44)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    albumNameLabel.text = nil
    artistNameLabel.text = nil
    noOfTracksLabel.text = nil
    albumCoverImageView.image = nil
  }
  
  func configure(with viewModel: NewReleasesCellViewModel) {
    albumNameLabel.text = viewModel.name
    artistNameLabel.text = viewModel.artistName
    noOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
    albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
  }
}
