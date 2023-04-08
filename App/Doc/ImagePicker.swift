//
//  ImagePicker.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

 class ImagePicker {

     static let defaultPicker = ImagePicker()

     func getImage(in viewController: ImageViewController) {

         let picker = UIImagePickerController()

         picker.delegate = viewController
         picker.sourceType = .photoLibrary

         viewController.present(picker, animated: true)

     }
 }
