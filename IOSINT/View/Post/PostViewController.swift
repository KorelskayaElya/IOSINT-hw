//
//  PostViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 23.01.2023.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate {
    
    weak var coordinator: SavedPostCoordinator?
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let coreDataService = CoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.delegate = self
        setupTableView()
        self.title = "Saved Posts"
        self.view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    func setupTableView() {
        self.view.addSubview(self.table)
        NSLayoutConstraint.activate([
            self.table.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    
    @objc func tap() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        tableView.reloadData()
    }
    
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataService.getContext().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.post = coreDataService.getContext()[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 720
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }


}
