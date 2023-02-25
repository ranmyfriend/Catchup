//
//  RedTableViewCell.swift
//  MultipleCell
//
//  Created by BKS-GGS on 24/02/23.
//

import UIKit

//Red Table View(Rule) ->
//Simple text with red background color and there is a button. And when it got tapped it should say tapped Red color

protocol RedTableViewCellAble: AnyObject {
    func didTapButton()
}

class RedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtLabel: UILabel!
    weak var delegate: RedTableViewCellAble?
    var model: RedTableModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        self.delegate?.didTapButton()
    }
    
}
