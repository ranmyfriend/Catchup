//
//  ChangePasswordViewController.swift
//  Refactoring
//
//  Created by BKS-GGS on 30/03/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet private(set) var navigationBar: UINavigationBar!
    @IBOutlet private(set) var cancelBarButton: UIBarButtonItem!
    @IBOutlet private(set) var oldPasswordTextField: UITextField!
    @IBOutlet private(set) var newPasswordTextField: UITextField!
    @IBOutlet private(set) var confirmPasswordTextField: UITextField!
    @IBOutlet private(set) var submitButton: UIButton!
    
//    private var passwordChanger: PasswordChanging = PasswordChanger()
    lazy var passwordChanger: PasswordChanging = PasswordChanger()
    
    var viewModel: ChangePasswordViewModel! {
        didSet {
            guard isViewLoaded else { return }
            if oldValue.isCancelButtonEnabled != viewModel.isCancelButtonEnabled {
                cancelBarButton.isEnabled = viewModel.isCancelButtonEnabled
            }
        }
    }
    
    private lazy var presenter = ChangePasswordPresenter(view: self, viewModel: viewModel)
    
    var securityToken = ""
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    let message = "Please enter a new password."

    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red: 55/255, green: 147/255, blue: 251/255, alpha: 1.0).cgColor
        submitButton.layer.cornerRadius = 8
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        
    }

    @IBAction private func cancel() {
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @IBAction private func changePassword() {
        guard validateInputs() else {
            return
        }
        
//        setUpWaitingAppearance()
//        attemptToChangePassword()
        
        if newPasswordTextField.text?.count ?? 0 < 6 {
            let alertController = UIAlertController(title: nil, message: "The new password should have at least 6 characters.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.newPasswordTextField.becomeFirstResponder()
            }
            
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return
        }
        
        if newPasswordTextField.text != confirmPasswordTextField.text {
            let alertController = UIAlertController(title: nil, message: "The new password and the confirmation pasword" + " " + "don't match. Please try again.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.newPasswordTextField.becomeFirstResponder()
            }
            
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return
        }
        
        //2. Set up waiting appearance
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        cancelBarButton.isEnabled = false
        view.backgroundColor = .clear
        view.addSubview(blurView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        
        
        //3. Attempt to change password
        passwordChanger.change(securityToken: securityToken, oldPassword: oldPasswordTextField.text ?? "", newPassword: newPasswordTextField.text ?? "") { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
            let alertController = UIAlertController(title: nil, message: "Your password has been successfully changed", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self?.present(alertController, animated: true)
        } onFailure: { [weak self] message in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.oldPasswordTextField.text = ""
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.oldPasswordTextField.becomeFirstResponder()
                self?.view.backgroundColor = .white
                self?.cancelBarButton.isEnabled = true
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self?.present(alertController, animated: true)
        }

    }
    
    private func validateInputs() -> Bool {
        if newPasswordTextField.text?.isEmpty ?? true {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return false
        }
        return true
    }

}


extension ChangePasswordViewController: ChangePasswordViewCommands {
    func hideActivityIndicator() {
        
    }
    
    func showActivitiyIndicator() {
        
    }
    
    
    
    
}
