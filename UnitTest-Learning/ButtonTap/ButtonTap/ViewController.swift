//
//  ViewController.swift
//  ButtonTap
//
//  Created by Ranjit on 17/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private(set) var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func buttonTap() {
        print(">> Button was tapped")
    }


}

