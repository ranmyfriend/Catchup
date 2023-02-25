//
//  ViewController.swift
//  MultipleCell
//
//  Created by BKS-GGS on 24/02/23.
//

import UIKit

/*
 Objective: ViewController going to contain 3 cells
 Cell 1 -> Simple text with red background color and there is a button. And when it got tapped it should say tapped Red color
 Cell 2 -> Simple text with blue background color and there is a Switch. And when it got toggled it should say tapped blue color
 Cell 3 -> Static Image with some loreum ipsum content
 */

/*
 How to achieve this? Lets plan it
 */

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    enum DataSourceType {
        case Red
        case Blue
        case Image
    }
    
    var dataSource: [DataSourceType] = [.Red, .Blue, .Image]
    var dataSourceArray = TableDataSource.dataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RedTableViewCell", bundle: nil), forCellReuseIdentifier: "RedTableViewCell")
        tableView.register(UINib(nibName: "BlueTableViewCell", bundle: nil), forCellReuseIdentifier: "BlueTableViewCell")
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .Red:
            return dataSourceArray.redModels.count
        case .Blue:
            return dataSourceArray.blueModels.count
        case .Image:
            return dataSourceArray.imageModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section] {
        case .Red:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedTableViewCell", for: indexPath) as! RedTableViewCell
            cell.model = dataSourceArray.redModels[indexPath.row]
            cell.delegate = self
            return cell
        case .Blue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlueTableViewCell", for: indexPath) as! BlueTableViewCell
            cell.model = dataSourceArray.blueModels[indexPath.row]
            cell.delegate = self
            return cell
        case .Image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.model = dataSourceArray.imageModels[indexPath.row]
            return cell
        }
    }
}

extension ViewController: RedTableViewCellAble, BlueTableViewCellAble {
    func didTapButton() {
        print("tapped Red color")
    }
    
    func didTapToggle() {
        print("tapped Blue color")
    }
    
}
