//
//  TextPicker.swift
//  App
//
//  Created by Эля Корельская on 04.04.2023.
//

import UIKit

class TextPicker {
    static let defaultPicker  = TextPicker()
    // не используется
    func getText(showPickerIn viewController: UIViewController, title: String, message: String, completion: ((_ text: String)->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()

        let alertOK = UIAlertAction(title: "OK", style: .default) { alert in
            if let text  = alertController.textFields?[0].text, text != ""
            {
                completion?(text)
            }
        }
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        viewController.present(alertController,animated: true)
    }
    // используется для создания текстового файла
    func getText(showPickerIn viewController: UIViewController, title: String, message: String, completion: ((_ text1: String, _ text2: String)->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()

        let alertOK = UIAlertAction(title: "OK", style: .default) { alert in
            if let text1  = alertController.textFields?[0].text, text1 != "",
               let text2  = alertController.textFields?[1].text, text2 != ""
            {
                completion?(text1, text2)
            }
        }
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        viewController.present(alertController,animated: true)
    }
}
