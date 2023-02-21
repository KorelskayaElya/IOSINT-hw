//
//  NetworkService.swift
//  IOSINT
//
//  Created by Эля Корельская on 20.02.2023.
//

import UIKit

var appConfiguration: AppConfiguration?
 
struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        
        switch  configuration {
        case .films(let value):
            guard let url = URL(string: value) else {return}
            dataTask(url)
        case .species(let value):
            guard let url = URL(string: value) else {return}
            dataTask(url)
        case .starships(let value):
            guard let url = URL(string: value) else {return}
            dataTask(url)
        }
    }
    static func dataTask(_ address: URL) {
            let session = URLSession.shared
            let task = session.dataTask(with: address) {data, response, error in

                if let error = error {
                    print("error: \(error.localizedDescription)")
                    //error: The Internet connection appears to be offline.
                } else {
                    guard let data = data else { return }
                    let str = String(decoding: data, as: UTF8.self)
                    print("data: \(str)")
                    if let httpResponse = response as? HTTPURLResponse {
                    print("allHeaderFields: \(httpResponse.allHeaderFields), statusCode: \(httpResponse.statusCode)")
                }
                }
            }
            task.resume()
        }
}



