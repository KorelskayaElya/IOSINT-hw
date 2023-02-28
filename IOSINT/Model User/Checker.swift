//
//  Checker.swift
//  IOSINT
//
//  Created by Эля Корельская on 15.01.2023.
//

import UIKit

final class Checker {
    // синглтон
    static var shared = Checker()
    // логин пароль для входа
    private let loginCheck: String = "kov@mail.ru"
    private let passCheck: String = "1234567"
    private let user = User(login: "hipster", fullName: "Hipster Cat", avatarImage: UIImage(named: "cat_image")!, status: "Waiting for smth...")

    func check(login: String, pass: String, completion: @escaping (Result<User, LogInErrors>) -> Void) {
        if (login == loginCheck) && (pass == passCheck) {
            completion(.success(user))
        } else {
            completion(.failure(LogInErrors.isNotAuthorized))
            return
        }
    }
}


