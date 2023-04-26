//
//  SavedPost.swift
//  IOSINT
//
//  Created by Эля Корельская on 23.04.2023.
//

import UIKit
import StorageService
// дочерный координатор - сменен на ввод пароля
final class SavedPostCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    func start() {
        let saveVC = PostViewController()
        saveVC.coordinator = self
        saveVC.tabBarItem.title = "Saved Post"
        saveVC.tabBarItem.image = UIImage(systemName: "hand.thumbsup.fill")
        navigationController.pushViewController(saveVC, animated: false)
    }
    
}

