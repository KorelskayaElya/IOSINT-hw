//
//  TemplateAlert.swift
//  IOSINT
//
//  Created by Эля Корельская on 27.02.2023.
//

import UIKit

// шаблон для вызова алерта
class TemplateErrorAlert {
    
    static let shared = TemplateErrorAlert()
    
    func alert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        // не работает
        LogInViewController().present(alert, animated: true, completion: nil)
    }
}

