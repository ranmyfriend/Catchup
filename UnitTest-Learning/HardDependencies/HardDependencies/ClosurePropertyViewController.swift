//
//  ClosurePropertyViewController.swift
//  HardDependencies
//
//  Created by Ranjit on 16/03/21.
//

import UIKit

class ClosurePropertyViewController: UIViewController {

    var makeAnalytics: () -> Analytics = {
        Analytics.shared
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeAnalytics().track(event: "viewDidAppear -\(type(of: self))")
    }

}
