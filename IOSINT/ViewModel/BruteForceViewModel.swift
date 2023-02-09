//
//  BruteForceViewModel.swift
//  IOSINT
//
//  Created by Эля Корельская on 08.02.2023.
//

import UIKit
// модель для перебора паролей
final class BruteForceViewModel {
    
     let passwordGenerator = GeneratorPassword()

     var passwordForBruting: String

     var brutedPassword: String? {
         didSet {
             self.passwordFound?(self)
         }
     }

     init(model: String) {
         self.passwordForBruting = model
     }

     var passwordFound: ((BruteForceViewModel) -> ())?

     func StartBrute() {
         print(passwordForBruting)

         let queue = DispatchQueue.global(qos: .utility)
         queue.async {
             self.brutedPassword = bruteForce(passwordToUnlock: self.passwordForBruting)
         }
     }
 }

     private func bruteForce(passwordToUnlock: String) -> String {
         let ALLOWED_CHARACTERS:   [String] = String().letters.map { String($0) }
         var password: String = ""
         while password != passwordToUnlock {
             password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
         }

         return password
     }

     extension String {
         var digits:      String { return "0123456789" }
         var lowerCase:   String { return "abcdefghijklmnopqrstuvwxyz" }
         var upperCase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
         var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
         var letters:     String { return lowerCase + upperCase }
         var printable:   String { return digits + letters + punctuation }



         mutating func replace(at index: Int, with character: Character) {
             var stringArray = Array(self)
             stringArray[index] = character
             self = String(stringArray)
         }
     }

     func indexOf(character: Character, _ array: [String]) -> Int {
         return array.firstIndex(of: String(character))!
     }

     func characterAt(index: Int, _ array: [String]) -> Character {
         return index < array.count ? Character(array[index])
                                    : Character("")
     }

     func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
         var str: String = string

         if str.count <= 0 {
             str.append(characterAt(index: 0, array))
         }
         else {
             str.replace(at: str.count - 1,
                         with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

             if indexOf(character: str.last!, array) == 0 {
                 str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
             }
         }

         return str
     }
