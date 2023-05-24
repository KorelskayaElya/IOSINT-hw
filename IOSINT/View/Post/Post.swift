//
//  Post.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
// хранилище постов
public struct PostStorage {
    public let author: String
    public let descriptionPost: String
    public let image: String
    public let likes: Int
    public let views: Int
    public static var post = [PostStorage(author: "netflix.com", descriptionPost: "Since 2013, Netflix has produced its own films and series, including animated films and TV programs. In 2016, the company produced 126 original series and films, more than any other network or cable channel.".localized, image: "image1.jpg", likes: 1, views: 13),
                              PostStorage(author: "kinopoisk.ru", descriptionPost: "House of Gucci (2021) An unceremonious commoner turns a fashion empire upside down. Scandalous drama by Ridley Scott.".localized, image: "image2.jpg", likes: 33, views: 190),
                              PostStorage(author: "Fresco by Michelangelo.com", descriptionPost: "The Creation of Adam (Sistine Chapel, Vatican, Rome, 1508–1512) is the fourth of nine central compositions in the cycle of frescoes on the theme of the creation of the world, commissioned by Michelangelo Buonarroti to decorate the ceiling of the Sistine Chapel by Pope Julius II.".localized, image: "image3.jpg", likes: 43, views: 19),
                              PostStorage(author: "sunset.com", descriptionPost: "Incredibly beautiful sight - sunset. When the sun, so close, big, crimson-red, fantastically beautiful, saying goodbye to a summer day, gently gives the last warm rays. And this is the most romantic time of the day, which gives rise to legends with attractive magic.".localized, image: "image4.jpg", likes: 133, views: 109)]
    
}

