//
//  MainCoordinator.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

protocol CoordinatbleMain: AnyObject {
    func switchToTabBar()
}

final class MainCoordinator: Coordinatble {
    
    // MARK: - Properties
    
    private var rootViewController: UIViewController
   
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    
    // MARK: - Methods
    
    func start() -> UIViewController {
        let loginCoordinator = LoginCoordinator(
            rootVuewController: self.rootViewController,
            parentCoordinator: self
        )
        self.addChildCoordinator(loginCoordinator)
        return loginCoordinator.start()
    }
    
    func switchToTabBarCoordinator() {
        self.childCoordinators.removeAll()
        
        let tabBarCoordinator = TabBarCoordinator(
            rootViewController: self.rootViewController,
            parentCoordinator: self
        )
        self.rootViewController = tabBarCoordinator.start()
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

extension MainCoordinator: CoordinatbleMain {
    
    func switchToTabBar() {
        self.switchToTabBarCoordinator()
    }

}

   
