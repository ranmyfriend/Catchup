//
//  TestingRootViewController.swift
//  AppLaunchTests
//
//  Created by Ranjit on 14/03/21.
//

import Foundation
import UIKit

class TestingRootViewController: UIViewController {

    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .white

        view = label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">> TEST Root ViewController Called")
    }
}
