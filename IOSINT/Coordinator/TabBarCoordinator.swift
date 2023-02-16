//
//  TabBarCoordinator.swift
//  IOSINT
//
//  Created by Эля Корельская on 31.01.2023.
//

import UIKit
// базовый уровень навигации приложения
class TabBarCoordinator: TabBarCoordinatorProtocol {
    
    var tabBarController: UITabBarController
    
    var coordinatorFeed: Coordinator?
    var coordinatorProfile: Coordinator?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
       
    }
    
    func start() {
        // связка дочерних и базовых координаторов
        let FeedController = UINavigationController()
        coordinatorFeed = FeedCoordinator(navigationController: FeedController)
        coordinatorFeed?.start()
        //UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().tintColor = UIColor(named: "Pink")
        UITabBar.appearance().backgroundColor = .systemBackground
        let feed = coordinatorFeed!
        
        let ProfileController = UINavigationController()
        coordinatorProfile = ProfileCoordinator(navigationController: ProfileController)
        coordinatorProfile?.start()
        let profile = coordinatorProfile!
        
        tabBarController.viewControllers = [feed.navigationController, profile.navigationController]
        
    }
}
