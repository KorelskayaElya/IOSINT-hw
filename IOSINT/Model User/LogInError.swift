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
/*
Реализовать CheckerService как Core-компонент - компонент, взаимодействующий с БД.

Закрыть его протоколом CheckerServiceProtocol.
Протокол будет требовать пару методов - checkCredentials и signUp, которые будут вызываться по нажатии на кнопки Login и Sign Up соответственно.
При реализации метода checkCredentials проверять, есть ли в БД пользователь с переданными учетными данными, вызывая метод Auth.auth().signIn(withEmail:, password:, completion:).
Если данный метод вернул ошибку, то показывать ее на экране в виде алерта. Регистрировать пользователя с помощью метода Auth.auth().createUser(withEmail:, password:, completion:).
Если на экране отрисована лишь одна кнопка Login, то необходимо продумать логику регистрации пользователя. При нажатии на нее сначала проверять, есть ли такой пользователь в БД:
Если такого пользователя нет, регистировать в БД.
Если такой пользователь есть, но введен неверный пароль, показать соответствующую ошибку.
Если пользователь есть, а введенные поля валидны, проходить авторизацию и открывать следующий экран.
При закрытии приложения не забыть пользователя разлогинить с помощью метода Auth.auth().signOut() в методе AppDelegate/SceneDelegate applicationWillTerminate/sceneDidDisconnect.

Вызывать методы CheckerService в сервисе/инспекторе LoginInspector, который закрыт протоколом LoginViewControllerDelegate и который инджектится в LoginViewController. LoginViewControllerDelegate требует те же методы, что и CheckerServiceProtocol. Получается LoginViewController имеет ссылку на LoginInspector в виде приватного свойства private weak var delegate: LoginViewControllerDelegate?. При нажатии на кнопки/кнопку, в реализации соответствующих функций/соответствующей функции, вызываются методы делегата checkCredentials или signUp.
*/

