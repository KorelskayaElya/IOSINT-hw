//
//  User.swift
//  IOSINT
//
//  Created by Эля Корельская on 20.12.2022.
//

import UIKit
import FirebaseAuth

protocol UserService {
    func checkLogin(login: String, password: String) -> User?
}

final class User {
    var login: String
    var fullName: String
    var avatarImage: UIImage
    var status: String
    var userPassword: String
    
    init(login: String, fullName: String, avatarImage: UIImage, status: String, userPassword: String) {
        self.login = login
        self.fullName = fullName
        self.avatarImage = avatarImage
        self.status = status
        self.userPassword = userPassword
    }
}

class CurrentUserService: UserService {
    let user = User(login: "kov@mail.ru", fullName: "Hipster Cat".localized, avatarImage: UIImage(named: "cat_image")!, status: "Waiting for smth...".localized, userPassword: "1234567")
    func checkLogin(login: String, password: String) -> User? {
        if (login == user.login) && (password == user.userPassword) {
            return user
        } else {
            return nil
        }
    }
}

//class TestUserService: UserService {
//    private let testUser = User(login: "dog", fullName: "DOGGERS", avatarImage: UIImage(named: "dog")!, status: "I'm hungry")
//    private let testPassword = "dog"
//    func checkLogin(login: String, password: String) -> User? {
//        if (login == testUser.login) && (password == testPassword) {
//            return testUser
//        } else {
//            return nil
//        }
//    }
//}
