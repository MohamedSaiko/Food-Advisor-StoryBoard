//
//  NavigationCoordinator.swift
//  Food-Advisor-StoryBoard
//
//  Created by Mohamed Sayed on 08.12.23.
//

import Foundation
import UIKit

struct NavigationCoordinator {
    
    func goto(viewControllerWithID id: String, navigationController: UINavigationController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        DispatchQueue.main.async {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
