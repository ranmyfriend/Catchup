//
//  TestTabBarViewController.swift
//  SpotifyTests
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation
import UIKit

final class TestTabBarViewController: UIViewController {
    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .red
        view = label
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TabBar View Controller"
        print(">> \(String(describing: TestTabBarViewController.self)) called")
    }
}
