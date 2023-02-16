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
    func toAVPlayer() {
         let avPlayerVC = MusicViewController()
         avPlayerVC.coordinator = self
         navigationController.navigationBar.tintColor = .black
         navigationController.pushViewController(avPlayerVC, animated: true)
     }
    func toVideoPlayer() {
        let videoPlayerVC = VideoViewController()
        videoPlayerVC.coordinator = self
        navigationController.pushViewController(videoPlayerVC, animated: true)
    }
    func toRecorder() {
        let recorderVC = RecorderViewController()
        recorderVC.coordinator = self
        navigationController.pushViewController(recorderVC, animated: true)
    }
}
