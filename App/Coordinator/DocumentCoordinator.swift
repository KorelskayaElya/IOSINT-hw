//
//  DocumentCoordinator.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

final class DocumentCoordinator: Coordinatble {
    
    // MARK: - Properties
        
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Methods

    func start() -> UIViewController {
        let imageViewController = ImageViewController()
       imageViewController.coordinator = self
        
        let imageNavigationController = UINavigationController(rootViewController: imageViewController)
        let tabBarItem = UITabBarItem(
            title: "Document",
            image: UIImage(systemName: "folder.circle.fill"),
            tag: 0
        )
        imageNavigationController.tabBarItem = tabBarItem
        
        return imageNavigationController
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
