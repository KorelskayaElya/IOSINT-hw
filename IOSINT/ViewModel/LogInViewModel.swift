//
//  LogInViewModel.swift
//  IOSINT
//
//  Created by Эля Корельская on 01.02.2023.
//

import UIKit
// создание модели для авторизации
final class LogInViewModel {
    
    static var logInFactoryDelegate: LogInFactory?

    var logInFactory: LogInFactory
    // уведомляет представление об изменениях
    var logInedUser: User? {
        didSet {
            self.checker?(self)
        }
    }

    var checker: ((LogInViewModel) -> ())?

    init(model: LogInFactory) {
        self.logInFactory = model
    }

    func startChecker(login: String, pass: String) throws {
        if login.isEmpty {
            throw LogInErrors.emptyLogin
        }
        
        if pass.isEmpty {
            throw LogInErrors.emptyPassword
        }
        
        guard let logUser = logInFactory.makeLogInInspector().check(login: login, password: pass) else {
            throw LogInErrors.isNotAuthorized}
        logInedUser = logUser
    }
}
