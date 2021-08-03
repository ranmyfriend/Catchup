//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by BKS-GGS on 03/08/21.
//

import UIKit
import SDWebImage

class SearchResultSubtitleDefaultTableViewCell: UITableViewCell {
  
  static let identifier = "SearchResultSubtitleDefaultTableViewCell"
  
  private let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textColor = .secondaryLabel
    return label
  }()
  
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(label)
    contentView.addSubview(subtitleLabel)
    contentView.addSubview(iconImageView)
    contentView.clipsToBounds = true
    accessoryType = .disclosureIndicator
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let imageSize: CGFloat = contentView.height-10
    iconImageView.frame = CGRect(x: 10, y: 0, width: imageSize, height: imageSize)
    
    let labelHeight = contentView.height/2
    label.frame = CGRect(x: iconImageView.right+10, y: 0, width: contentView.width-iconImageView.right-15, height: labelHeight)
    subtitleLabel.frame = CGRect(x: iconImageView.right+10, y: label.bottom, width: contentView.width-iconImageView.right-15, height: labelHeight)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    iconImageView.image = nil
    label.text = nil
    subtitleLabel.text = nil
  }
  
  
  func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
    label.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
    iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
  }
  
}
