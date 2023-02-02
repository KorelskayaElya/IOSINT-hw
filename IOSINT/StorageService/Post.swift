//
//  Post.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
// структура поста
public struct Post {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
}
// хранилище постов
public struct PostStorage {
    public static var post: [Post] = [Post(author: "netflix.com", description: "С 2013 года Netflix производит собственные фильмы и сериалы, в том числе и анимационные, а также телепрограммы. В 2016 году компания выпустила 126 оригинальных сериалов и фильмов — больше, чем любой другой сетевой или кабельный канал.", image: "image1", likes: 13, views: 13),
                                Post(author: "kinopoisk.ru", description: "Дом Gucci (2021) Бесцеремонная простолюдинка переворачивает модную империю вверх дном. Скандальная драма Ридли Скотта.", image: "image2", likes: 1345, views: 190),
                                Post(author: "Fresco by Michelangelo.com", description: "«Сотворение Адама» (Сикстинская капелла, Ватикан, Рим, 1508–1512) – четвертая из девяти центральных композиций цикла фресок на тему сотворения мира, заказанных Микеланджело Буонарроти для украшения потолка Сикстинской капеллы папой Юлием II.", image: "image3", likes: 25, views: 19),
                                Post(author: "sunset.com", description: "Невероятно красивое зрелище – закат солнца. Когда солнце, такое близкое, большое, багряно-красное, фантастически красивое, прощаясь с летним днем, ласково дарит последние теплые лучи. И это самое романтичное время суток, которое рождает легенды, обладающие притягивающим волшебством.", image: "image4", likes: 130, views: 109)]
    
}

