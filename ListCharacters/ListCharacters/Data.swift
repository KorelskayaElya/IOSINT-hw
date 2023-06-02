//
//  Data.swift
//  ListCharacters
//
//  Created by Эля Корельская on 01.06.2023.
//

import SwiftUI

struct Post: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let description: String
    let image: Image
    let image1: Image
}

let data = [
    Post(id: 0,
         title: "Губка Боб",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Жёлтая антропоморфная морская губка, которая обычно носит коричневые короткие штаны, белую рубашку с воротником и красный галстук. Живёт в ананасовом доме и работает поваром в ресторане быстрого питания под названием «Красти Краб». Он прилежно посещает лодочную школу миссис Пафф, но никогда не сдавал её; на протяжении всей серии он изо всех сил пытается сдать экзамены, но остаётся непреднамеренно безрассудным водителем лодки. Он безумно оптимистичен и полон энтузиазма по отношению к своей работе и своим друзьям. Интересы – ловля медуз, пускание мыльных пузырей, игры со своим лучшим другом Патриком и непреднамеренное раздражение своего соседа Сквидварда. Он впервые появился в эпизоде «Требуется помощник».
         """,
         image: Image("SpongeBob"),
         image1: Image("sp1")),
    Post(id: 1,
         title: "Сквидвард Тентаклс",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Кальмар с большим носом, работает кассиром в ресторане «Красти Краб». Ближайший сосед Губки Боба с сухим, саркастическим чувством юмора. Его дом находится между домами Губки Боба и Патрика. Считает себя талантливым художником и музыкантом, но никто больше не признаёт его способности. Играет на кларнете и часто пишет автопортреты в разных стилях, которые развешивает вокруг своего жилого дома в форме моаи. Сквидвард часто выражает своё недовольство Губкой Бобом, но в глубине души он искренне заботится о нём. Это проявилось в виде внезапных признаний, когда Сквидвард оказался в ужасной ситуации.
         """,
         image: Image("skvi"),
         image1:Image("sp2")),
    Post(id: 2,
         title: "Патрик Стар",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Розовая морская звезда, которая живёт под камнем и носит шорты с цветами. Самая яркая черта его характера – крайне низкий интеллект. Лучший друг Губки Боба и часто бессознательно поощряет действия, которые приводят двоих к неприятностям. На протяжении всего мультсериала он безработный, но, как того требует сюжетная линия каждого эпизода, выполняет различные краткосрочные работы. Обычно он медлителен и лёгок в ходу, но иногда может становиться агрессивным, как настоящая морская звезда, а иногда совершает великие подвиги.
         """,
         image: Image("patrick"),
         image1:Image("sp3")),
    Post(id: 3,
         title: "Планктон",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Одноглазый организм из газа (копепод). Является главным антагонистом сериала. Владелец ресторана «Помойное ведро» (англ. Chum Bucket), стилизованного под железную урну и абсолютно не пользующегося спросом из-за отвратительной еды. У Планктона завышенная самооценка, но при этом он страдает комплексом неполноценности. На протяжении нескольких лет пытается украсть секретный рецепт крабсбургера, но безуспешно, что и является причиной давней вражды с бывшим другом и однокурсником Юджином Крабсом. Почти всех родственников Планктона проглотил кит, с тех пор Планктон панически боится китообразных, в том числе и Перл. По мнению родителей, должен был стать офисным работником или деловым администратором.

         В студенческие годы дружил с Крабсом. Ныне живёт в «Помойном ведре» со своей компьютерной женой Карен. Часто попадает в тюрьму, где даже стал авторитетом. Мечтает стать гигантом и захватить весь подводный мир. Атомные испытания в атолле Бикини в сериале объясняются именно проделками Планктона. В серии «Армия Планктона» собирает армию себе подобных и штурмует «Красти Краб». А в полнометражном фильме наконец узнаёт формулу крабсбургеров! Если он и побеждает мистера Крабса, его всегда останавливает Губка Боб.
         """,
         image: Image("plan"),
         image1:Image("sp4")),
    Post(id: 4,
         title: "Сэнди Чикс",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Белка из Техаса, которая живёт в наполненном воздухом стеклянном куполе и носит гидрокостюм, чтобы дышать под водой. Всякий раз, когда какие-либо морские существа входят в её дом, они должны носить водные шлемы. Сэнди работает учёной, исследовательницей и изобретательницей. Она чемпионка по родео и увлекается различными видами спорта, такими как сэндбординг и карате. Она говорит с южным растяжением и использует типичные южно-сленговые слова и фразы.
         """,
         image: Image("sandy"),
         image1:Image("sp5")),
    Post(id: 5,
         title: "Улитка Гэри",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Домашняя морская улитка Губки Боба, которая живёт в ананасовом доме и мяукает, как кошка. Другие улитки и Губка Боб могут понимать его
         и разговаривать с ним. Изображённый как уравновешенный персонаж, Гэри часто служит голосом разума и фольгой для Губки Боба и решает
         проблемы, которые не может его хозяин. У него розовая ракушка, которая невероятно просторна внутри.
         """,
         image: Image("gery"),
         image1:Image("sp6")),
    Post(id: 6,
         title: "Перл Крабс",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Кашалот-подросток и дочь мистера Крабса. Хочет соответствовать своим сверстникам-рыбам, но считает это невозможным из-за большого размера, присущего её виду. Она унаследует Красти Краб от её отца, когда вырастет, но всё ещё учится в старшей школе и ещё не работает в семейном бизнесе. Интересы – работа в торговом центре Бикини-Боттом, использование кредитной карты отца для покупки чего-нибудь стильного и прослушивание поп-музыки
         """,
         image: Image("perl"),
         image1:Image("sp7")),
    Post(id: 7,
         title: "Морской Супермен и Очкарик",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Два пожилых супергероя, которые живут в доме престарелых и являются звёздами любимого телешоу Губки Боба и Патрика. Морской Супермен известен тем, что полностью забывает о вещах и постоянно кричит «ЗЛО!», когда он слышит слово, Очкарик кажется умнее, рассудительнее и раздражительнее из них двоих. В эпизоде «Водяной марафон» подтверждает, что их имена – Эрни и Тим, отсылка к именам их соответствующих актёров озвучивания. Художница Рамона Фрейдон нарисовала комиксы о приключениях этих персонажей. После смерти Боргнайна в 2012 году и Конуэя в 2019 году оба персонажа были ограничены появлениями камео.
         """,
         image: Image("superman"),
         image1:Image("sp8")),
    Post(id: 8,
         title: "Миссис Пафф",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Рыба-ёж, учительница Губки Боба в школе управления катерами, учебном заведении для подводных водителей, где ученики управляют катерами, как автомобилями. Она носит матросский костюм, а её школа похожа на маяк. Губка Боб – самый преданный ученик миссис Пафф и знает ответы на все вопросы на её экзаменах, но всегда паникует и проваливает задания, когда на самом деле садится за руль. Она надувается как шар, когда она расстроена, напугана или травмирована. Она часто бывает задержана полицией, и, как правило, несёт ответственность за Губку Боба, когда он вызывает разрушение вокруг Бикини Боттома во время занятий или экзаменов.
         """,
         image: Image("puff"),
         image1:Image("sp9")),
    Post(id: 9,
         title: "Карэн",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Компьютерная жена Планктона. Обладает многими человеческими свойствами: разговаривает, готовит еду, выражает разные эмоции, чем сильно отличается от обычного робота или компьютера. Многие идеи для кражи секретного рецепта крабсбургера принадлежат именно ей, хотя Планктон нередко присваивает их себе, за что Карен обижается на мужа.
         """,
         image: Image("karen"),
         image1:Image("sp10")),
    Post(id: 10,
         title: "Мистер Крабс",
         subtitle: "Источник: Губка Боб Квадратные Штаны",
         description:
         """
         Красный краб, который живёт в доме в форме якоря со своей дочерью Перл, которая является кашалотом. Он не любит тратить деньги, но пойдёт на всё, чтобы сделать Перл счастливой. Владеет и управляет рестораном «Красти Краб», где работает Губка Боб. Он самодовольный, хитрый и одержимый ценностью и сущностью денег. Он склонен больше беспокоиться о своём богатстве, чем о потребностях своих сотрудников. После службы на флоте он любит парусный спорт, морские лачуги и разговаривает по-пиратски.
         """,
         image: Image("krabs"),
         image1:Image("sp11")),
]
