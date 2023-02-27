//
//  LogInViewControllerDelegate.swift
//  IOSINT
//
//  Created by Эля Корельская on 17.01.2023.
//

import UIKit

protocol LogInViewControllerDelegate {

    func check(login: String, password: String) -> User?
    
}
