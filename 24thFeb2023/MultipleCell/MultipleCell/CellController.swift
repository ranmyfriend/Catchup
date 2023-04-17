//
//  CellController.swift
//  MultipleCell
//
//  Created by BKS-GGS on 26/02/23.
//

import Foundation
import UIKit

//Sepration of DataSource and Delegate,
//Voilating SRP
protocol CellController: AnyObject {
    /*
     // We can use like this on ViewController and move this method from CellController
     var configureTableView: ((UITableView) -> Void)?
     */
    func configure(tableView: UITableView)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
