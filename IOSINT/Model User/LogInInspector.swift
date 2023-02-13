//
//  LoginInspector.swift
//  IOSINT
//
//  Created by Эля Корельская on 16.01.2023.
//

import UIKit

//struct LogInInspector: LogInViewControllerDelegate {
//
//    func check(login: String, pass: String) -> Bool {
//        return Checker.shared.check(login: login, pass: pass)
//    }
//
//}
struct LogInInspector: LogInViewControllerDelegate {
    func check(login: String, pass: String) -> User? {
        
        var user: User?
        Checker.shared.check(login: login, pass: pass) { result in
            switch result {
            case .success(let myUser):
                user = myUser
            case .failure( _):
                return
            }
        }
        return user
    }
}


        
