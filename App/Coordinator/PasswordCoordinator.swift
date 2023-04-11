//
//  PasswordCoordinator.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

protocol CoordinatbleLogin: AnyObject {
    func switchToTabBarCoordinator()
}

final class LoginCoordinator: Coordinatble {
    
    // MARK: - Properties

    private weak var parentCoordinator: CoordinatbleMain?
    
    private var rootViewController: UIViewController
    
    private(set) var childCoordinators: [Coordinatble] = []
    
    
    // MARK: - Life cycle

    init(rootVuewController: UIViewController, parentCoordinator: CoordinatbleMain? ) {
        self.rootViewController = rootVuewController
        self.parentCoordinator = parentCoordinator
    }
    
    
    // MARK: - Methods

    func start() -> UIViewController {
        let loginViewController = PasswordViewController()
        loginViewController.coordinator = self
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        self.rootViewController.addChild(navigationController)
        navigationController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self.rootViewController)
        
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

extension LoginCoordinator: CoordinatbleLogin {
    
    func switchToTabBarCoordinator() {
        self.parentCoordinator?.switchToTabBar()
    }
}
