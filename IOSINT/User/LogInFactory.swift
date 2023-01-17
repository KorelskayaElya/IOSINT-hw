//
//  LogInFactory.swift
//  IOSINT
//
//  Created by Эля Корельская on 17.01.2023.
//

import UIKit

protocol LogInFactory {
    func makeLoginInspector() -> LogInInspector
}

struct MyLoginFactory: LogInFactory {
    
    func makeLoginInspector() -> LogInInspector {
        return LogInInspector()
    }
}
