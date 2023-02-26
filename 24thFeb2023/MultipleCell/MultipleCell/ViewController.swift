//
//  ViewController.swift
//  MultipleCell
//
//  Created by BKS-GGS on 24/02/23.
//

import UIKit

/*
 Topic: Table/Collection Views with multiple cell types
 Youtube Video link: https://www.youtube.com/watch?app=desktop&v=hvdAX3YxUpw&embeds_euri=https%3A%2F%2Fwww.essentialdeveloper.com%2F&feature=emb_logo
 Author: Essential Developer
 */

/*
 Objective: ViewController going to contain 3 cells
 Cell 1 -> Simple text with red background color and there is a button. And when it got tapped it should say tapped Red color
 Cell 2 -> Simple text with blue background color and there is a Switch. And when it got toggled it should say tapped blue color
 Cell 3 -> Static Image with some loreum ipsum content
 */

/*
 Achieved using Polymorphism using CellController interface
 Polymorphism i belive it is much much better :)
 */

class ViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
        
    lazy var dataSource: [CellController] = [
        RedCellController(models: TableDataSource.dataSource().redModels, delegate: self),
        BlueCellController(models: TableDataSource.dataSource().blueModels, delegate: self),
        ImageCellController(models: TableDataSource.dataSource().imageModels)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.forEach({$0.configure(tableView: tableView)})
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
}

extension ViewController: RedTableViewCellDelegate, BlueTableViewCellDelegate {
  
    func didTapButton() {
        print("tapped Red color")
    }

    func didTapToggle() {
        print("tapped Blue color")
    }

}
