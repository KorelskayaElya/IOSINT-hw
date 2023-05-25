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
                 // Если пользователь не найден - предлагаем создать
                 case AuthErrorCode.userNotFound.rawValue:
                     let alert = UIAlertController(title: "Пользователь не найден".localized, message: "Хотите создать аккаунт?".localized, preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "Нет".localized, style: .cancel, handler: {_ in print("Пользователь не хочет создавать аккаунт".localized)}))
                     alert.addAction(UIAlertAction(title: "Да".localized, style: .default, handler: {_ in self.signUp(login: login, password: password)}))
                     UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
                 // другие ошибки
                 default:
                     TemplateErrorAlert.shared.alert(alertTitle: "Необходимо придерживаться формата kov@mail.ru".localized, alertMessage: error.localizedDescription)
                     print("другие ошибки".localized)
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
                     TemplateErrorAlert.shared.alert(alertTitle: "Ошибка регистрации".localized, alertMessage: error.localizedDescription)
                 } else {
                     // нет ошибок и в базу записывается логин пароль от аккаунта
                     TemplateErrorAlert.shared.alert(alertTitle: "Аккаунт создан".localized, alertMessage: "Ваш аккаунт успешно создан!".localized)
                 }
             }
     }
 }
