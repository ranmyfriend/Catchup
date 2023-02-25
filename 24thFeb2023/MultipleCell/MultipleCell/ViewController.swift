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
        case Red([RedTableModel])
        case Blue([BlueTableModel])
        case Image([ImageTableModel])
    }
    
    var dataSource: [DataSourceType] = [
        DataSourceType.Red(TableDataSource.dataSource().redModels),
        DataSourceType.Blue(TableDataSource.dataSource().blueModels),
        DataSourceType.Image(TableDataSource.dataSource().imageModels)
    ]
    
    var realDataSource: [RedCellController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realDataSource = [RedCellController(models: TableDataSource.dataSource().redModels, delegate: self)]
        tableView.register(UINib(nibName: "RedTableViewCell", bundle: nil), forCellReuseIdentifier: "RedTableViewCell")
        tableView.register(UINib(nibName: "BlueTableViewCell", bundle: nil), forCellReuseIdentifier: "BlueTableViewCell")
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
    }

}


protocol RedCellControllable: AnyObject {
    //Sending an event to the cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    //Receiving an event from the cell
    func didTapButton()
}

extension RedCellControllable {
    func didTapButton() { }
}

class RedCellController: RedCellControllable {
    let models: [RedTableModel]
    weak var delegate: RedCellControllable?
    
    init(models: [RedTableModel], delegate: RedCellControllable? = nil) {
        self.models = models
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedTableViewCell", for: indexPath) as! RedTableViewCell
        cell.model = models[indexPath.row]
        cell.didTapButton = {[weak self] in
            self?.delegate?.didTapButton()
        }
        return cell
    }

}

extension ViewController: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
////        return dataSource.count
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realDataSource.count
//        switch dataSource[section] {
//        case .Red(let models):
////            return models.count
//
//        case .Blue(let models):
//            return models.count
//        case .Image(let models):
//            return models.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        realDataSource[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
//        switch dataSource[indexPath.section] {
//        case .Red(let models):
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RedTableViewCell", for: indexPath) as! RedTableViewCell
//            cell.model = models[indexPath.row]
//            cell.delegate = self
//            return cell
//        case .Blue(let models):
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BlueTableViewCell", for: indexPath) as! BlueTableViewCell
//            cell.model = models[indexPath.row]
//            cell.delegate = self
//            return cell
//        case .Image(let models):
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
//            cell.model = models[indexPath.row]
//            return cell
//        }
    }
}

extension ViewController: RedCellControllable, BlueTableViewCellAble {
    func didTapButton() {
        print("tapped Red color")
    }

    func didTapToggle() {
        print("tapped Blue color")
    }

}
