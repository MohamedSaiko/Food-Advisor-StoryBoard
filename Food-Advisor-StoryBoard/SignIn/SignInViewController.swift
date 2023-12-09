//
//  SignInViewController.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 08.04.23.
//

import UIKit

final class SignInViewController: UIViewController {
    
    private let signInViewModel = SignInViewModel(authenticationManager: AuthenticationManager(), navigationCoordinator: NavigationCoordinator())
    
    @IBOutlet weak private var userNameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func signInButtonTapped(_ sender: UIButton) {
        
        guard let userName = userNameTextField.text,
                let password = passwordTextField.text,
                let navigationController = navigationController else {
            return
        }
        signInViewModel.authenticateUser(userName: userName, password: password, navigationController: navigationController)
    }
}
