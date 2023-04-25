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
    public static var post = [PostStorage(author: "netflix.com", descriptionPost: "С 2013 года Netflix производит собственные фильмы и сериалы, в том числе и анимационные, а также телепрограммы. В 2016 году компания выпустила 126 оригинальных сериалов и фильмов — больше, чем любой другой сетевой или кабельный канал.", image: "image1.jpg", likes: 13, views: 13),
                              PostStorage(author: "kinopoisk.ru", descriptionPost: "Дом Gucci (2021) Бесцеремонная простолюдинка переворачивает модную империю вверх дном. Скандальная драма Ридли Скотта.", image: "image2.jpg", likes: 33, views: 190),
                              PostStorage(author: "Fresco by Michelangelo.com", descriptionPost: "«Сотворение Адама» (Сикстинская капелла, Ватикан, Рим, 1508–1512) – четвертая из девяти центральных композиций цикла фресок на тему сотворения мира, заказанных Микеланджело Буонарроти для украшения потолка Сикстинской капеллы папой Юлием II.", image: "image3.jpg", likes: 43, views: 19),
                              PostStorage(author: "sunset.com", descriptionPost: "Невероятно красивое зрелище – закат солнца. Когда солнце, такое близкое, большое, багряно-красное, фантастически красивое, прощаясь с летним днем, ласково дарит последние теплые лучи. И это самое романтичное время суток, которое рождает легенды, обладающие притягивающим волшебством.", image: "image4.jpg", likes: 133, views: 109)]
    
}

