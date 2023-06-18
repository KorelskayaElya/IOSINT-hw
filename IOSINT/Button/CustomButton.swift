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
     let tapClosure: (() -> ())
    // инициализатор кнопки
     init(customButtonTitle: String,
          closure: @escaping (() -> ())) {

         self.tapClosure = closure
         super.init(frame: .zero)

         setTitle(customButtonTitle, for: .normal)
         setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
         backgroundColor = UIColor(named: "ColorBlue")
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
