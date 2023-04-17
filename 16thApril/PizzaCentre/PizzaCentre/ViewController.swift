//
//  ViewController.swift
//  PizzaCentre
//
//  Created by BKS-GGS on 16/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let smallPizza = Pizza(pType: .Small, tType: .Cheese)
        let pizzaOrder = PizzaOrder()
        pizzaOrder.order(pizza: smallPizza)
        
        let mediumPizza = Pizza(pType: .Medium, tType: .Cheese)
        pizzaOrder.order(pizza: mediumPizza)

        
    }


}

