//
//  SettingsCoordinator.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

final class SettingsCoordinator: Coordinatble {
    
    // MARK: - Properties
    
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Methods
    
    func start() -> UIViewController {
        let profileViewController = SettingsViewController()
        
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        let tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 0
        )
        profileNavigationController.tabBarItem = tabBarItem
        
        return profileNavigationController
    }
    
    func addChildCoordinator(_ coordinator: Coordinatble) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatble) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
}


