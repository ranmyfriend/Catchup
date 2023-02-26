//
//  BlueTableViewCellController.swift
//  MultipleCell
//
//  Created by BKS-GGS on 26/02/23.
//

import Foundation
import UIKit

class BlueCellController: CellController {
    
    let models: [BlueTableModel]
    weak var delegate: BlueTableViewCellDelegate?
    
    init(models: [BlueTableModel], delegate: BlueTableViewCellDelegate? = nil) {
        self.models = models
        self.delegate = delegate
    }
    
    func configure(tableView: UITableView) {
        tableView.register(UINib(nibName: "BlueTableViewCell", bundle: nil), forCellReuseIdentifier: "BlueTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlueTableViewCell", for: indexPath) as! BlueTableViewCell
        cell.configure(model: models[indexPath.row])
        cell.delegate = delegate
        return cell
    }
}
