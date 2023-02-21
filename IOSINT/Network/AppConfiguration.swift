//
//  AppConfiguration.swift
//  IOSINT
//
//  Created by Эля Корельская on 20.02.2023.
//

import UIKit

enum AppConfiguration: CaseIterable {
    
    
    typealias AllCases = [AppConfiguration]
    
    case films(String)
    case species(String)
    case starships(String)
    
    static var allCases: AllCases {
        return [
            .films("https://swapi.dev/api/films/1/"),
            .species("https://swapi.dev/api/species/3/"),
            .starships("https://swapi.dev/api/starships/5/")
        ]
    }
    
    
}

