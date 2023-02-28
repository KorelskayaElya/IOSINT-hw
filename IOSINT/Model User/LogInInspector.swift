//
//  LoginInspector.swift
//  IOSINT
//
//  Created by Эля Корельская on 16.01.2023.
//

import UIKit

struct LogInInspector: LogInViewControllerDelegate {
    func check(login: String, password: String) -> User? {
        
        var user: User?
        CheckerService.shared.checkCredentials(login: login, password: password)
        
        Checker.shared.check(login: login, pass: password) { result in
            switch result {
            case .success(let myUser):
                CheckerService.shared.isSingIn = true
                user = myUser
            case .failure( _):
                CheckerService.shared.isSingIn = false
                return
            }
        }
        return user
    }
}

    
    


        
