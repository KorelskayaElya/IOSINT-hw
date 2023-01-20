//
//  LoginInspector.swift
//  IOSINT
//
//  Created by Эля Корельская on 16.01.2023.
//

import UIKit

struct LogInInspector: LogInViewControllerDelegate {
    
    func check(login: String, pass: String) -> Bool {
        return Checker.shared.check(login: login, pass: pass)
    }
}
