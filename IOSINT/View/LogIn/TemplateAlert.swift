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
        UIApplication.topViewController()!.present(alert, animated: true)
    }
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

