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
    var logInedUser: Bool {
        didSet {
            self.checker?(self)
        }
    }

    var checker: ((LogInViewModel) -> ())?

    init(model: LogInFactory) {
        self.logInFactory = model
    }

    // нужно ли отлавливать ошибку здесь ?
    func startChecker(login: String, password: String) {
        do {
            // не понимаю как обратиться 
            let logUser = try logInFactory.makeLogInInspector().check(login: login, password: password)
            logInedUser = logUser
        } catch LogInErrors.emptyLogin  {
            TemplateErrorAlert.shared.alert(alertTitle: "Ошибка", alertMessage: "Пустое поле")
        } catch LogInErrors.emptyPassword {
            TemplateErrorAlert.shared.alert(alertTitle: "Ошибка", alertMessage: "Пустое поле")
        } catch LogInErrors.isNotAuthorized {
            TemplateErrorAlert.shared.alert(alertTitle: "Ошибка", alertMessage: "Неверная авторизация")
        } catch {
            print("мы не смогли понять что не так")
        }
        
    }
}
