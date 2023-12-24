//
//  SignInViewModel.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation
import UIKit

final class SignInViewModel {
    
    private let authenticationManager: AuthenticationManager
    private let navigationCoordinator: NavigationCoordinator
    
    init(authenticationManager: AuthenticationManager, navigationCoordinator: NavigationCoordinator) {
        self.authenticationManager = authenticationManager
        self.navigationCoordinator = navigationCoordinator
    }
    
    func authenticateUser(userName: String, password: String, navigationController: UINavigationController) {
        authenticationManager.authenticate(userName: userName, password: password) { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationCoordinator.goto(viewControllerWithID: homeViewControllerID, navigationController: navigationController)
        }
    }
}
