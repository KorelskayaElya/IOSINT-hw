//
//  Photos.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit

struct ViewPhotoModel {
    var imageName: UIImage?
    static func addPhotos() -> [ViewPhotoModel] {
        var photos: [ViewPhotoModel] = []
        for index in 0..<21 {
            photos.append(ViewPhotoModel(imageName: UIImage(named: "person\(index + 1)")))
        }
        return photos
    }
}
