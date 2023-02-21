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
    case starships(String)
    case species(String)
    
    static var allCases: AllCases {
        return [
            .films("https://swapi.dev/api/films/1/"),
            .starships("https://swapi.dev/api/starships/3/"),
            .species("https://swapi.dev/api/species/5/")
        ]
    }
}

