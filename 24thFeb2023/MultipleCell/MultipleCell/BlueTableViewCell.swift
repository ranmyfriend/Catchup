//
//  BlueTableViewCell.swift
//  MultipleCell
//
//  Created by BKS-GGS on 24/02/23.
//

import UIKit

//BlueTableViewCell: Rule
//-> Simple text with blue background color and there is a Switch. And when it got toggled it should say tapped blue color

protocol BlueTableViewCellAble: AnyObject {
    func didTapToggle()
}

class BlueTableViewCell: UITableViewCell {

    @IBOutlet weak var txtLabel: UILabel!
    weak var delegate: BlueTableViewCellAble?
    var model: BlueTableModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func didTapToggle(_ sender: Any) {
        self.delegate?.didTapToggle()
    }
}
