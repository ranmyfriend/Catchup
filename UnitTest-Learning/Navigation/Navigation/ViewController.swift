//
//  ViewController.swift
//  Navigation
//
//  Created by Ranjit on 18/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private(set) var codePushButton: UIButton!
    @IBOutlet private(set) var codeModalButton: UIButton!
    @IBOutlet private(set) var seguePushButton: UIButton!
    @IBOutlet private(set) var segueModalButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func pushNextViewController() {
        let nextVC = CodeNextViewController(labelText: "Pushed from code")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction private func presentModalNextViewController() {
        let nextVC = CodeNextViewController(labelText: "Modal from code")
        self.present(nextVC, animated: true)
        print(">> CodeNextViewController Presented!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "pushNext":
            guard let nextVC = segue.destination as? SegueNextViewController else {
                return
            }
            nextVC.labelText = "Pushed from segue"
        case "modalNext":
            guard let nextVC = segue.destination as? SegueNextViewController else {
                return
            }
            nextVC.labelText = "Modal from segue"
        default:
            return
        }
    }
    
    deinit {
        print(">> ViewController.deinit")
    }

}

