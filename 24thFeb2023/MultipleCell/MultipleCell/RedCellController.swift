//
//  RedCellController.swift
//  MultipleCell
//
//  Created by BKS-GGS on 26/02/23.
//

import Foundation
import UIKit

//Feedback
/*
 1)there should not be controller(ie.naming) ex: RedCellController
 2)Static vs dynamic refer.NSNotificationCenter
 */


class RedCellController: CellController {
    let models: [RedTableModel]
    weak var delegate: RedTableViewCellDelegate? 
    
    init(models: [RedTableModel], delegate: RedTableViewCellDelegate? = nil) {
        self.models = models
        self.delegate = delegate
    }
    func configure(tableView: UITableView) {
        tableView.register(UINib(nibName: "RedTableViewCell", bundle: nil), forCellReuseIdentifier: "RedTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedTableViewCell", for: indexPath) as! RedTableViewCell
        cell.configure(model: models[indexPath.row])
        cell.delegate = delegate
        return cell
    }

}
