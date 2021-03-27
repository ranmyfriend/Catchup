//
//  TestWelcomeViewController.swift
//  SpotifyTests
//
//  Created by BKS-GGS on 27/03/21.
//

import UIKit

final class TestWelcomeViewController: UIViewController {
    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .red
        view = label
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome View Controller"
        print(">> \(String(describing: TestWelcomeViewController.self)) called")
    }
}

