//
//  ScreenCreate.swift
//  IOSINT
//
//  Created by Эля Корельская on 01.02.2023.
//

import UIKit

protocol Create: AnyObject {
    func createPhoto() -> UIViewController
    func createLogin(coordinator: ProfileCoordinator) -> UIViewController
}

final class ScreenCreate: Create {
    func createPhoto() -> UIViewController {
        let model = ViewModel.photos
        let viewModel = PhotoViewModel(model: model)
        let view = PhotosViewController()
        
        view.viewModel = viewModel
        return view
    }

    func createLogin(coordinator: ProfileCoordinator) -> UIViewController {
        let view = LogInViewController(checkerService: CheckerService.shared)
        view.coordinator = coordinator
        return view
    }
    
    func createProfile(user: User, coordinator: ProfileCoordinator) -> UIViewController {
        let image = PostStorage.post
        let viewModel = ProfileViewModel(userfromLogin: user,
                                         images: image)
        let view = ProfileViewController()
        view.coordinator = coordinator
        
        view.viewModel = viewModel
        return view
    }
}
