//
//  TestHelpers.swift
//  TextFieldTests
//
//  Created by BKS-GGS on 27/03/21.
//

import Foundation
import UIKit

extension UITextContentType: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}

extension UITextAutocorrectionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default: return "default"
        case .no: return "no"
        case .yes: return "yes"
        @unknown default: fatalError("Unknown UITextAutocorrectionType")
        }
    }
}


func shouldChangeCharacters​(in textField: UITextField, range: NSRange = NSRange(), replacement: String) -> Bool? {
    textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: replacement)
}

@discardableResult func shouldReturn(in textField: UITextField) -> Bool? {
    textField.delegate?.textFieldShouldReturn?(textField)
}

func putInViewHierarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}
