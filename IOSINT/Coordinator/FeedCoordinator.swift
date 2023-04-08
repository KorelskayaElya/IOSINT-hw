//
//  FeedCoordinator.swift
//  IOSINT
//
//  Created by Эля Корельская on 31.01.2023.
//

import UIKit
import StorageService
// дочерный координатор - сменен на ввод пароля
final class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    // tab bar нормально грузил но не работал launch screen
    func start() {
        //let feedVC = FeedViewController()
        // для KeyChain
        let foldervc = ImageViewController()
        foldervc.coordinator = self
        //foldervc.tabBarItem.title = "Documents"
        foldervc.tabBarItem = UITabBarItem(title: "Documnets", image: UIImage(systemName: "folder.circle.fill"), tag:1)
        navigationController.pushViewController(foldervc, animated: false)
    }
    
    
    
    // это не надо
    
//    func goToPostViewController() {
//        let postVC = PostViewController()
//        navigationController.pushViewController(postVC, animated: true)
//    }
//    func toAVPlayer() {
//         let avPlayerVC = MusicViewController()
//         avPlayerVC.coordinator = self
//         navigationController.navigationBar.tintColor = .black
//         navigationController.pushViewController(avPlayerVC, animated: true)
//     }
//    func toVideoPlayer() {
//        let videoPlayerVC = VideoViewController()
//        videoPlayerVC.coordinator = self
//        navigationController.pushViewController(videoPlayerVC, animated: true)
//    }
//    func toRecorder() {
//        let recorderVC = RecorderViewController()
//        recorderVC.coordinator = self
//        navigationController.pushViewController(recorderVC, animated: true)
//    }
//    func toInfo() {
//        let infovc = InfoViewController()
//        infovc.coordinator = self
//        navigationController.pushViewController(infovc, animated: true)
//    }
//    func toImage() {
//        let imagevc = ImageViewController()
//        imagevc.coordinator = self
//        navigationController.pushViewController(imagevc, animated: true)
//    }
}
