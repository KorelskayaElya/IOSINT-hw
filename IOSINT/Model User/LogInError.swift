//
//  LogInError.swift
//  IOSINT
//
//  Created by Эля Корельская on 13.02.2023.
//

import UIKit

enum LogInErrors: Error {
     case emptyLogin
     case emptyPassword
     case isNotAuthorized
 }

 extension LogInErrors: CustomStringConvertible {
     var description: String {
         switch self {
         case .emptyLogin: return "Пустой логин"
         case .emptyPassword: return "Пустой пароль"
         case .isNotAuthorized: return "Неверная авторизация"
         }
     }
 }
