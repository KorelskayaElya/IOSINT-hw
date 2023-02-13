//
//  Checker.swift
//  IOSINT
//
//  Created by Эля Корельская on 15.01.2023.
//

import UIKit

final class Checker {
    
    static var shared = Checker()
    
     private let loginCheck: String = "123"
     private let passCheck: String = "123"
     private let user = User(login: "hipster", fullName: "Hipster Cat", avatarImage: UIImage(named: "cat_image")!, status: "Waiting for smth...")
    //var user: User?
    
    func check(login: String, pass: String, completion: @escaping (Result<User, LogInErrors>) -> Void) {
        if (login == loginCheck) && (pass == passCheck) {
//            user = User(login: "hipster", fullName: "Hipster Cat", avatarImage: UIImage(named: "cat_image")!, status: "Waiting for smth...")
//                return true
            completion(.success(user))
        } else {
            //return false
            completion(.failure(LogInErrors.isNotAuthorized))
            return
        }
    }
}
protocol LoginViewControllerDelegate {
    func check(login: String, pass: String) -> Bool
}

