//
//  ProfileViewModel.swift
//  IOSINT
//
//  Created by Эля Корельская on 02.02.2023.
//

import UIKit

// создание модели для профиля
class ProfileViewModel {
    
    var images: [PostStorage]?
    // уведомляет представление об изменениях
    var user: User? {
        didSet {
            self.userChange?(self)
        }
    }
    
    var userChange: ((ProfileViewModel) -> ())?
    
    init(userfromLogin: User, images: [PostStorage]) {
        self.images = images
    }
}
