//
//  ProfileCoordinator.swift
//  IOSINT
//
//  Created by Эля Корельская on 31.01.2023.
//

import UIKit
import FirebaseAuth
// дочерний координатор
final class ProfileCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    let screenCreate = ScreenCreate()
    let currentUserService = CurrentUserService()
    let checkerService = CheckerService.shared
    lazy var loginVC: LogInViewController = {
        let vc = LogInViewController(checkerService: checkerService)
        vc.coordinator = self
        return vc
    }()

    func start() {
        let loginVC = screenCreate.createLogin(coordinator: self)
        loginVC.tabBarItem.title = "Profile".localized
        loginVC.tabBarItem.image = UIImage(systemName: "person.fill")
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    
    func goToProfileViewController() {
        let profileVC = screenCreate.createProfile(user: currentUserService.user, coordinator: self)
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func goToPhotosViewController() {
        let photoVC = screenCreate.createPhoto()
        navigationController.pushViewController(photoVC, animated: true)
    }
}
