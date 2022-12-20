//
//  User.swift
//  IOSINT
//
//  Created by Эля Корельская on 20.12.2022.
//

import UIKit

protocol UserService {
    func checkLogin(login: String, password: String) -> User?
}

class User {
    let login: String
    let fullName: String
    let avatarImage: UIImage
    let status: String
    
    init(login: String, fullName: String, avatarImage: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatarImage = avatarImage
        self.status = status
    }
}
class CurrentUserService: UserService {
    private let user = User(login: "hipster", fullName: "Hipster Cat", avatarImage: UIImage(named: "cat_image")!, status: "Waiting for smth...")
    private let userPassword = "cat"
    func checkLogin(login: String, password: String) -> User? {
        if (login == user.login) && (password == userPassword) {
            return user
        } else {
            return nil
        }
    }
}
class TestUserService: UserService {
    private let testUser = User(login: "dog", fullName: "DOGGERS", avatarImage: UIImage(named: "dog")!, status: "I'm hungry")
    private let testPassword = "dog"
    func checkLogin(login: String, password: String) -> User? {
        if (login == testUser.login) && (password == testPassword) {
            return testUser
        } else {
            return nil
        }
    }
}
