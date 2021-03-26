//
//  TestRootViewController.swift
//  SpotifyTests
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation
import UIKit

final class TestRootViewController: UIViewController {
    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .red
        view = label
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">> \(String(describing: TestRootViewController.self)) called")
    }
}
