//
//  ScreenCreate.swift
//  IOSINT
//
//  Created by Эля Корельская on 01.02.2023.
//

import UIKit

protocol Create: AnyObject {
    func createPhoto() -> UIViewController
    func createLogin(coordinator: ProfileCoordinator, localAuthService: LocalAuthorizationService) -> UIViewController
}
final class ScreenCreate: Create {
    func createPhoto() -> UIViewController {
        let model = ViewModel.photos
        let viewModel = PhotoViewModel(model: model)
        let view = PhotosViewController()
        
        view.viewModel = viewModel
        return view
    }

    func createLogin(coordinator: ProfileCoordinator, localAuthService: LocalAuthorizationService) -> UIViewController {
        let model = MyLogInFactory()
       let viewModel = LogInViewModel(model: model)
       let view = LogInViewController()
       view.coordinator = coordinator
       view.viewModel = viewModel
       view.localAuthService = localAuthService
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
