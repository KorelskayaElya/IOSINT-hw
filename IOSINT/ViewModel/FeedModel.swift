//
//  Secret.swift
//  IOSINT
//
//  Created by Эля Корельская on 23.01.2023.
//

import UIKit

final class FeedModel {
    
    private let secret = "0000"
    
    func check(secretWord: String) -> Bool {
        secretWord == secret
    }
}
// структура title json
struct Title: Decodable {
    var title: String
}
// структура планеты json
struct Planet: Decodable {
     var name: String
     var period: String
     var residents: [String]

     enum CodingKeys: String, CodingKey {
         case name
         case period = "orbital_period"
         case residents
     }
 }
// вытаскивает title из запроса
func getTitleItem(completion: ((_ getItemTitle: String?) -> ())?) {
    
     let url = URL(string: "https://jsonplaceholder.typicode.com/todos/34")
     let task = URLSession.shared.dataTask(with: url!) { data, response, error in

         if let error {
             print(error.localizedDescription)
             completion?(nil)
             return
         }

         if (response as! HTTPURLResponse).statusCode != 200 {
             print("Status code != 200, statusCode = \((response as! HTTPURLResponse).statusCode)")
             completion?(nil)
             return
         }

         guard let data else {
             print("data is nil")
             completion?(nil)
             return
         }

         do {
             let answer  = try JSONSerialization.jsonObject(with: data) as? [String: Any]
             if let getItemTitle = answer?["title"] as? String {
                 completion?(getItemTitle)
                 return
             }
         } catch {
             print(error)
         }

         completion?(nil)
     }
     task.resume()
 }
// вытаскивает orbital period
func getPeriod(completion: ((_ planetItem: Planet?) -> ())?) {
    
     let url = URL(string: "https://swapi.dev/api/planets/1/")
     let task = URLSession.shared.dataTask(with: url!) { data, response, error in

         if let error {
             print(error.localizedDescription)
             completion?(nil)
             return
         }

         if (response as! HTTPURLResponse).statusCode != 200 {
             print("Status code != 200, statusCode = \((response as! HTTPURLResponse).statusCode)")
             completion?(nil)
             return
         }

         guard let data else {
             print("data is nil")
             completion?(nil)
             return
         }

         do {
             let answer = try JSONDecoder().decode(Planet.self, from: data)
             // полностью ответ вытаскивает ссответсвующий структуре
             completion?(answer)
             return
         } catch {
             print(error)
         }

         completion?(nil)
     }
     task.resume()
 }
