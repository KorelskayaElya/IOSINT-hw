//
//  LogInFactory.swift
//  IOSINT
//
//  Created by Эля Корельская on 17.01.2023.
//

import UIKit

protocol LogInFactory {
    func makeLogInInspector() -> LogInInspector
}
struct MyLogInFactory: LogInFactory {
    func makeLogInInspector() -> LogInInspector {
        return LogInInspector()
    }
}
