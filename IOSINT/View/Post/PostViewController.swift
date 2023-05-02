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
    var isSorted = false
    var savedPosts: [PostStorage] = []
    var filteredAuthor: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        navigationController?.delegate = self
        setupTableView()
        self.title = "Saved Posts"
        self.view.backgroundColor = .systemBackground
        table.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap))
        navigationItem.rightBarButtonItem?.tintColor = .black
        let authorFilterBtn = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(authorSearch))
        let clearFilterBtn = UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(clearFilter))
        navigationItem.leftBarButtonItems = [authorFilterBtn, clearFilterBtn]
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func returnPosts() -> [PostStorage] {
        if isSorted == false {
            savedPosts = coreDataService.getContext()
        } else {
            savedPosts = coreDataService.getContextByAuthor(author: filteredAuthor!)
        }
        return savedPosts
    }
    @objc func authorSearch() {
        let alert = UIAlertController(title: "Поиск по автору", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Имя автора"
        }
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel))
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { [self] _ in
            guard let textField = alert.textFields?[0].text else {return}
            filteredAuthor = textField
            isSorted = true
            table.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func clearFilter() {
        isSorted = false
        filteredAuthor = nil
        table.reloadData()
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
        self.view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    
    @objc func tap() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        table.reloadData()
    }
    
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        returnPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.post = returnPosts()[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 720
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            self.coreDataService.deleteContext(profilePostModel: self.returnPosts()[indexPath.row])
            tableView.reloadData()
            success(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action])
    }


}
