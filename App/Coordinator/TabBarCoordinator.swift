//
//  TabBarCoordinator.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

final class TabBarCoordinator: Coordinatble {
    
    // MARK: - Properties

    private weak var parentCoordinator: CoordinatbleMain?
    
    private var rootViewController: UIViewController
    
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle

    init(rootViewController: UIViewController, parentCoordinator: CoordinatbleMain?) {
        self.rootViewController = rootViewController
        self.parentCoordinator = parentCoordinator
    }
    
    
    // MARK: - Methods

    func start() -> UIViewController {
        // Создаем flow Feed
        let feedCoordinator = DocumentCoordinator()
        self.addChildCoordinator(feedCoordinator)
        
        // Создаем flow Profile
        let profileCoordinator = SettingsCoordinator()
        self.addChildCoordinator(profileCoordinator)

        // Создаем tabBarController
        let tabBarController = TabBarController(navControllers: [
            feedCoordinator.start(),
            profileCoordinator.start()
        ])
        
        // Теперь делаем переход из Login на TabBar
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.addChild(tabBarController)
        tabBarController.view.frame = self.rootViewController.view.bounds
        UITabBar.appearance().tintColor = UIColor(named: "Pink")
        
        self.rootViewController.transition(
            from: self.rootViewController.children[0],
            to: tabBarController,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {},
            completion: {_ in
                self.rootViewController.children[0].removeFromParent()
                tabBarController.didMove(toParent: self.rootViewController)
            }
        )
        
        
        return self.rootViewController
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


