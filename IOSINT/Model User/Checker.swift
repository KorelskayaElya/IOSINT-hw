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
    
    private var loginCheck: String
    private var passwordCheck: String
    
    private init() {
        self.loginCheck = "kov@mail.ru"
        self.passwordCheck = "1234567"
    }
    

    func check(login: String, pass: String, completion: @escaping (Result<Bool, LogInErrors>) -> Void) {
        if (login == loginCheck) && (pass == passwordCheck) {
            completion(.success(true))
        } else {
            completion(.failure(LogInErrors.isNotAuthorized))
            return
        }
    }
}


