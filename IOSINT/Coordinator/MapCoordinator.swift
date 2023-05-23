//
//  MapCoordinator.swift
//  IOSINT
//
//  Created by Эля Корельская on 21.05.2023.
//

import UIKit
// дочерный координатор - сменен на ввод пароля
final class MapCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    func start() {
        let mapVC = MapViewController()
        mapVC.coordinator = self
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(systemName: "mappin.circle.fill")
        navigationController.pushViewController(mapVC, animated: false)
    }
    
}


