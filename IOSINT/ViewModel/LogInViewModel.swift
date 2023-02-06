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
    
    func startChecker(login: String, pass: String) {
        if logInFactory.makeLogInInspector().check(login: login, pass: pass) {
            logInedUser = Checker.shared.user
        } else {
            logInedUser = nil
        }
    }
}
