//
//  LogInViewControllerDelegate.swift
//  IOSINT
//
//  Created by Эля Корельская on 17.01.2023.
//

import UIKit

protocol LogInViewControllerDelegate {
    // вызывается в LoginViewController 
    func check(login: String, password: String) -> Bool
    
}
