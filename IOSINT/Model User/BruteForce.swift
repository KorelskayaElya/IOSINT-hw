//
//  BruteForce.swift
//  IOSINT
//
//  Created by Эля Корельская on 08.02.2023.
//

import UIKit
// структура перебора паролей
struct GeneratorPassword {
    
    var lowerCase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var upperCase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var letters:     String { return lowerCase + upperCase }
// получение рандомного пароля из 4х символов
    func getRandomPassword(charSet: String, passwordLen: Int) -> String {
         let characters: [String] = charSet.map { String($0) }
         var randomPassword = ""
         for _ in 1...passwordLen {
             randomPassword += characters.randomElement()!
         }

         return randomPassword
     }
 }
