//
//  RealmModel.swift
//  App
//
//  Created by Эля Корельская on 10.04.2023.
//

import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
}


