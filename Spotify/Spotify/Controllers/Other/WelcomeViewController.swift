//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-50-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
    }
    
    @objc func didTapSignIn() {
        let authViewController = AuthViewController()
        authViewController.navigationItem.largeTitleDisplayMode = .never
        authViewController.authCompletionHandler = { [weak self] success in
            self?.handleSignIn(success: success)
        }
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // Log user in or yell at them for error
    }
}
