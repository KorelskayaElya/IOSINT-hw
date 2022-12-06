//
//  ProfileViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let GroupSection = ["Photos","---"]

    private var post: [Post] = [Post(author: "netflix.com", description: "С 2013 года Netflix производит собственные фильмы и сериалы, в том числе и анимационные, а также телепрограммы. В 2016 году компания выпустила 126 оригинальных сериалов и фильмов — больше, чем любой другой сетевой или кабельный канал.", image: "image1", likes: 13, views: 13),
                                Post(author: "kinopoisk.ru", description: "Дом Gucci (2021) Бесцеремонная простолюдинка переворачивает модную империю вверх дном. Скандальная драма Ридли Скотта.", image: "image2", likes: 1345, views: 190),
                                Post(author: "Fresco by Michelangelo.com", description: "«Сотворение Адама» (Сикстинская капелла, Ватикан, Рим, 1508–1512) – четвертая из девяти центральных композиций цикла фресок на тему сотворения мира, заказанных Микеланджело Буонарроти для украшения потолка Сикстинской капеллы папой Юлием II.", image: "image3", likes: 25, views: 19),
                                Post(author: "sunset.com", description: "Невероятно красивое зрелище – закат солнца. Когда солнце, такое близкое, большое, багряно-красное, фантастически красивое, прощаясь с летним днем, ласково дарит последние теплые лучи. И это самое романтичное время суток, которое рождает легенды, обладающие притягивающим волшебством.", image: "image4", likes: 130, views: 109)]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setupView() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate, ButtonDelegate {
    func didTapButton(sender: UIButton) {
        let newViewController = PhotosViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHeaderView
            else { return nil }

            let viewModel = ProfileTableHeaderView.ViewModel(name: "Hipster Cat", description: "Waiting for smth...", image: nil)
            headerView.setup(with: viewModel)
            print(section)
            return headerView
        }
        return nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return GroupSection.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 720
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 240
        } else {
            return 20
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.post.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            let viewModel = PhotosTableViewCell.ViewModel(title: "Photos", image: nil)
            cell.delegate = self
            cell.setup(with: viewModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
            cell.setup(with: post[indexPath.row])
            return cell
        }
    }

}

