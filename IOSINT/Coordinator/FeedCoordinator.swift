//
//  FeedCoordinator.swift
//  IOSINT
//
//  Created by Эля Корельская on 31.01.2023.
//

import UIKit
import StorageService
// дочерный координатор
class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "homekit")
        navigationController.pushViewController(feedVC, animated: false)
    }
    
    func goToPostViewController() {
        let postVC = PostViewController()
        navigationController.pushViewController(postVC, animated: true)
    }
}
