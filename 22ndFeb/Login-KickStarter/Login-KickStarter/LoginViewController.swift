//
//  LoginViewController.swift
//  Login-KickStarter
//
//  Created by Ranjit on 23/02/21.
//

import UIKit

internal final class LoginViewController: UIViewController {
    
    @IBOutlet fileprivate var emailTextField: UITextField!
    @IBOutlet fileprivate var forgotPasswordButton: UIButton!
    @IBOutlet fileprivate var formBackgroundView: UIView!
    @IBOutlet fileprivate var formDividerView: UIView!
    @IBOutlet fileprivate var loginButton: UIButton!
    @IBOutlet fileprivate var passwordTextField: UITextField!
    @IBOutlet fileprivate var rootStackView: UIStackView!
    @IBOutlet fileprivate var showHidePasswordButton: UIButton!
    
    internal let viewModel: LoginViewModelType = LoginViewModel()

//    internal static func instantiate() -> LoginViewController {
//      return Storyboard.Login.instantiate(LoginViewController.self)
//    }



    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)

        self.emailTextField.addTarget(
          self,
          action: #selector(self.emailTextFieldDoneEditing),
          for: .editingDidEndOnExit
        )

        self.emailTextField.addTarget(
          self,
          action: #selector(self.emailTextFieldChanged(_:)),
          for: [.editingDidEndOnExit, .editingChanged]
        )

        self.passwordTextField.addTarget(
          self,
          action: #selector(self.passwordTextFieldDoneEditing),
          for: .editingDidEndOnExit
        )

        self.passwordTextField.addTarget(
          self,
          action: #selector(self.passwordTextFieldChanged(_:)),
          for: .editingChanged
        )

        self.showHidePasswordButton.addTarget(
          self,
          action: #selector(self.showHidePasswordButtonTapped),
          for: .touchUpInside
        )

        self.viewModel.inputs.viewDidLoad()
        
    }
    
    @objc internal func emailTextFieldChanged(_ textField: UITextField) {
      self.viewModel.inputs.emailChanged(textField.text)
    }

    @objc internal func emailTextFieldDoneEditing() {
      self.viewModel.inputs.emailTextFieldDoneEditing()
    }

    @objc internal func passwordTextFieldChanged(_ textField: UITextField) {
      self.viewModel.inputs.passwordChanged(textField.text)
    }

    @objc internal func passwordTextFieldDoneEditing() {
      self.viewModel.inputs.passwordTextFieldDoneEditing()
    }
    
    @objc func showHidePasswordButtonTapped() {
      self.viewModel.inputs.showHidePasswordButtonTapped()
    }
    
    @objc internal func dismissKeyboard() {
      self.view.endEditing(true)
    }


}

