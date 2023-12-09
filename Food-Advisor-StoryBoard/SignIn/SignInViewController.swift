//
//  SignInViewController.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 08.04.23.
//

import UIKit

class SignInViewController: UIViewController {
    
    let signInViewModel = SignInViewModel(authenticationManager: AuthenticationManager(), navigationCoordinator: NavigationCoordinator())
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        guard let userName = userNameTextField.text,
                let password = passwordTextField.text,
                let navigationController = navigationController else {
            return
        }
        signInViewModel.authenticateUser(userName: userName, password: password, navigationController: navigationController)
    }
}
