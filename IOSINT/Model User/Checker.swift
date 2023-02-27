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
     private let loginCheck: String = "123"
     private let passCheck: String = "123"

    func checkOfChecker(login: String, pass: String) -> Result<Bool, LogInErrors> {
        if (login == loginCheck) && (pass == passCheck) {
            return .success(true)
        } else {
            return .failure(.isNotAuthorized)
        }
    }
}


