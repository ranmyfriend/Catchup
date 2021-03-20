//
//  ViewController.swift
//  UserDefaults
//
//  Created by Ranjit on 20/03/21.
//

import UIKit

/*
 Note: Extrack a Protocol to Support 'Test Doubles'
 
 “What’s a test double? It’s like a stunt double in filmmaking. We temporarily replace the real actor with someone that looks like that actor. Or in our case, something that looks like the original type as far as the calling code is concerned.”
 */

/*
 Using protocol we can mock and test any type of persistence. but when you want to test CORE-Data avoid this test double mechanism. because core data stores the data in memory store.
 */

protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey defaultName: String)
    func integer(forKey defaultName: String) -> Int
}

extension UserDefaults: UserDefaultsProtocol { }

class ViewController: UIViewController {
    
    @IBOutlet private(set) var counterLabel: UILabel!
    @IBOutlet private(set) var incrementButton: UIButton!
    
    //To making this variable to test the functionlity of persistance storage
//    var userDefaults = UserDefaults.standard
    var userDefaults: UserDefaultsProtocol = UserDefaults.standard
    
    private var count = 0 {
        didSet {
            counterLabel.text = "\(count)"
            userDefaults.set(count, forKey: "count")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        count = userDefaults.integer(forKey: "count")
    }
    
    @IBAction private func incrementButtonTapped() {
        count += 1
    }


}

