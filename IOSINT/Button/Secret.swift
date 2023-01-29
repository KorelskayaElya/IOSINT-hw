//
//  Secret.swift
//  IOSINT
//
//  Created by Эля Корельская on 23.01.2023.
//

import UIKit

class FeedModel {
    
    private let secret = "0000"
    
    func check(secretWord: String) -> Bool {
         secretWord == secret
    }
}
