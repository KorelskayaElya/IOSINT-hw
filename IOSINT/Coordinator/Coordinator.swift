//
//  Coordinator.swift
//  IOSINT
//
//  Created by Эля Корельская on 31.01.2023.
//

import UIKit
// базовые координаторы
protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}

protocol TabBarCoordinatorProtocol: AnyObject {
    
    var tabBarController: UITabBarController { get set }
    
    func start()
}
