//
//  LoginInspector.swift
//  IOSINT
//
//  Created by Эля Корельская on 16.01.2023.
//

import UIKit

struct LogInInspector: LogInViewControllerDelegate {
    // вызывается в LoginViewController 
    func check(login: String, password: String) -> Bool {
        // проверка учетных данных
        CheckerService.shared.checkCredentials(login: login, password: password)
        // флаг проверки для открытия вью
        if CheckerService.shared.isSingIn == true {
            return true
        } else {
            return false
        }
    }
}
    
    


        
