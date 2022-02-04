//
//  ViewController.swift
//  SwiftUIPreviewsOnUIKit
//
//  Created by BKS-GGS on 04/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var incrementButton: UIButton!
    
    var counter: Int = 0 {
        didSet {
            counterLabel.text = "Counter: \(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        incrementButton.addAction(UIAction { [weak self] _ in
            self?.counter += 1
        }, for: .touchUpInside)
        
    }
}

import UIViewPreview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()!
        }
    }
}
#endif
