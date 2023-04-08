//
//  TabBarController.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life cycle

    init(navControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = navControllers
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods

    private func setupView() {
        UITabBar.appearance().tintColor = UIColor(named:"Pink")
        UITabBar.appearance().backgroundColor = .white
    }
    
}

