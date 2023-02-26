//
//  RedTableViewCell.swift
//  MultipleCell
//
//  Created by BKS-GGS on 24/02/23.
//

import UIKit

//Red Table View(Rule) ->
//Simple text with red background color and there is a button. And when it got tapped it should say tapped Red color

//It could be delegate or if there is one single button action you want to perform. Then, you can we go with closure
// like: var didTapButton: (() -> Void)?
protocol RedTableViewCellDelegate: AnyObject {
    func didTapButton()
}

class RedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtLabel: UILabel!
    weak var delegate: RedTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(model: RedTableModel) {
        self.txtLabel.text = model.txt
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        delegate?.didTapButton()
    }
    
}
