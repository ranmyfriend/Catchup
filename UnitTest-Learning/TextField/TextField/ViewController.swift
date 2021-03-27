//
//  ViewController.swift
//  TextField
//
//  Created by BKS-GGS on 27/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private(set) var userNameField: UITextField!
    @IBOutlet private(set) var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self
        passwordField.delegate = self
    }
    
    private func performLogin(username: String, password: String) {
        print("Username:\(username)")
        print("Password:\(password)")
    }
    
    deinit {
        print("ViewController.deinit")
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField === userNameField {
            return !string.contains(" ")
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === userNameField {
            passwordField.becomeFirstResponder()
        } else {
            guard let username = userNameField.text,
                  let password = passwordField.text else {
                return false
            }
            passwordField.resignFirstResponder()
            performLogin(username: username, password: password)
        }
        return false
    }
}

