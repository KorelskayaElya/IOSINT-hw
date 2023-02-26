//
//  InfoViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 26.02.2023.
//

import UIKit

class InfoViewController: UIViewController {
    weak var coordinator: FeedCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "JSON"
        view.backgroundColor = UIColor(named: "Pink")
        view.addSubview(labelTitle)
        view.addSubview(labelPlanet)
        constraint()
        // 1 задание
        getTitleItem { getItemTitle in
             guard let getItemTitle else { return }
            // перевод на главный поток
             DispatchQueue.main.async {
                 self.labelTitle.text = getItemTitle
             }
         }
        // 2 задание
        getPeriod { planetItem in
            guard let planetItem else { return }
            // перевод на главный поток
            DispatchQueue.main.async {
                self.labelPlanet.text = planetItem.period
            }
        }
    }
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times New Roman", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        return label
    }()
    private lazy var labelPlanet: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Times New Roman", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        return label
    }()
    
    func constraint() {
        NSLayoutConstraint.activate([
            
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.widthAnchor.constraint(equalToConstant: 300),
            labelTitle.heightAnchor.constraint(equalToConstant: 50),
            labelTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            labelPlanet.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPlanet.widthAnchor.constraint(equalToConstant: 50),
            labelPlanet.heightAnchor.constraint(equalToConstant: 50),
            labelPlanet.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
            ])
    }
    
}
