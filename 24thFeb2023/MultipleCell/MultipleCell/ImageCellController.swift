//
//  ImageCellController.swift
//  MultipleCell
//
//  Created by BKS-GGS on 26/02/23.
//

import Foundation
import UIKit

class ImageCellController: CellController {
    
    let models: [ImageTableModel]
    
    init(models: [ImageTableModel], delegate: CellController? = nil) {
        self.models = models
    }
    
    func configure(tableView: UITableView) {
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        cell.configure(model: models[indexPath.row])
        return cell
    }
}

