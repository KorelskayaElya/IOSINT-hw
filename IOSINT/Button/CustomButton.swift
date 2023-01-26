//
//  CustomButton.swift
//  IOSINT
//
//  Created by Эля Корельская on 23.01.2023.
//

import UIKit
// класс кнопки CustomButton
class CustomButton: UIButton {
    // замыкание
     private let tapClosure: (() -> ())
    // инициализатор кнопки
     init(customButtonTitle: String,
          closure: @escaping (() -> ())) {

         self.tapClosure = closure
         super.init(frame: .zero)

         setTitle(customButtonTitle, for: .normal)
         tintColor = .systemBlue
         backgroundColor = .systemGreen
         translatesAutoresizingMaskIntoConstraints = false
         addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
     }

     @objc private func buttonTapped() {
        tapClosure()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
