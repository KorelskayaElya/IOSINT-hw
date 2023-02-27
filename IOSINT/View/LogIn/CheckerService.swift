//
//  CheckerService.swift
//  IOSINT
//
//  Created by Эля Корельская on 26.02.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

 protocol CheckerServiceProtocol {
     // проверка учетных данных
     func checkCredentials(login: String, password: String)
     // зарегестрироваться
     func signUp(login: String, password: String)
 }

 class CheckerService: CheckerServiceProtocol {
     // синглтон
     static let shared = CheckerService()

     // флаг успешного логина
     var isSingIn: Bool = false

     // проверка учетных данных (должен вызываться при нажатии на кнопку)
     func checkCredentials(login: String, password: String) {
         // заполнение формы
         Auth.auth().signIn(withEmail: login, password: password) { [self] result, error in
             if let error = error {
                 print("error: \(error)")
                 let err = error as NSError
                 switch err.code {
                 //Если пользователь не найден - предлагаем создать
                 case AuthErrorCode.userNotFound.rawValue:
                     let alert = UIAlertController(title: "Пользователь не найден", message: "Хотите создать аккаунт?", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: {_ in print("Пользователь не хочет создавать аккаунт")}))
                     alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in self.signUp(login: login, password: password)}))
                    LogInViewController().present(alert, animated: true, completion: nil)
                 // другие ошибки
                 default:
                     TemplateErrorAlert.shared.alert(alertTitle: "Ошибка входа", alertMessage: error.localizedDescription)
                 }
             } else {
                 // успешный вход
                 isSingIn = true
             }
         }
     }
     // регистрация нового пользователя (вызвать при нажатии на кнопку)
     func signUp(login: String, password: String) {
         // создать нового пользователя
             Auth.auth().createUser(withEmail: login, password: password) { result, error in
                 if let error = error {
                     // любые ошибки
                     TemplateErrorAlert.shared.alert(alertTitle: "Ошибка регистрации", alertMessage: error.localizedDescription)
                 } else {
                     // нет ошибок
                     TemplateErrorAlert.shared.alert(alertTitle: "Аккаунт создан", alertMessage: "Поздравляем! Ваш аккаунт успешно создан!")
                 }
             }
     }
 }
