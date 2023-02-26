//
//  ImageTableViewCell.swift
//  MultipleCell
//
//  Created by BKS-GGS on 24/02/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(model: ImageTableModel) {
        self.txtLabel.text = model.txt
        self.imgView.image = UIImage(systemName: model.imageName)
    }
    
}
