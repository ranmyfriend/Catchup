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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RedTableViewCell", bundle: nil), forCellReuseIdentifier: "RedTableViewCell")
        tableView.register(UINib(nibName: "BlueTableViewCell", bundle: nil), forCellReuseIdentifier: "BlueTableViewCell")
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedTableViewCell", for: indexPath) as! RedTableViewCell
            return cell
        } else if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlueTableViewCell", for: indexPath) as! BlueTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            return cell
        }
        
    }
}
