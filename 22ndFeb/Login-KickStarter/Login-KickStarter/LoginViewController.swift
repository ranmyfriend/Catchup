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

    internal static func instantiate() -> LoginViewController {
      return Storyboard.Login.instantiate(LoginViewController.self)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

