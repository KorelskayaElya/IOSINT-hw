//
//  ProfileViewModel.swift
//  IOSINT
//
//  Created by Эля Корельская on 02.02.2023.
//

import UIKit
import StorageService
// создание модели для профиля
class ProfileViewModel {
    
    var images: [Post]?
    // уведомляет представление об изменениях
    var user: User? {
        didSet {
            self.userChange?(self)
        }
    }
    
    var userChange: ((ProfileViewModel) -> ())?
    
    init(userfromLogin: User, images: [Post]) {
        self.images = images
    }
    
}
