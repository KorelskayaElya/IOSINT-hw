//
//  ProfileViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ProfileViewController: UIViewController {
    let coreDataService = CoreDataService()
    let GroupSection = ["Photos","---"]
    
    var newUser: User? = nil
    weak var coordinator: ProfileCoordinator?
    private var images = [PostStorage]()
    // обновление информации
    var viewModel: ProfileViewModel! {
        didSet {
            self.viewModel.userChange = { [ weak self ] viewModel in
                self?.newUser = viewModel.user ?? nil
                self?.images = viewModel.images ?? []
                viewModel.images = self?.coreDataService.getContext()
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
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
        self.setupBackground()
        self.setupView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setupBackground() {
        #if DEBUG
        tableView.backgroundColor = .brown
        #else
        tableView.backgroundColor = .red
        #endif
    }
    
    private func setupView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        // разлогиниваем при уходе со страницы
         do {
             try Auth.auth().signOut()
             // ставим флаг
             CheckerService.shared.isSingIn = false
         } catch {
             print("is not signOut")
         }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate, ButtonDelegate {
    func didTapButton(sender: UIButton) {
       coordinator?.goToPhotosViewController()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHeaderView
            else { return nil }
            if let newUser = newUser {
                headerView.setup(fullName: newUser.fullName, avatarImage: newUser.avatarImage, status: newUser.status)
            }
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
            //print("viewModel.images?.count",viewModel.images?.count ?? 1)
            return viewModel.images?.count ?? 1
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
            cell.post = viewModel.images?[indexPath.row]
            let tap = UITapGestureRecognizer(target: self, action: #selector(addPost))
            tap.numberOfTapsRequired = 2
            cell.addGestureRecognizer(tap)
            return cell
        }
    }
    @objc func addPost(_ sender: UITapGestureRecognizer) {
        let coreDataService = CoreDataService.shared
        guard let indexPath = tableView.indexPathForRow(at: sender.location(in: self.tableView)) else { return }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
        cell.post = viewModel.images?[indexPath.row]
        coreDataService.saveContext(
            postModel: .init(
                author: viewModel.images?[indexPath.row].author ?? "error",
                descriptionPost: viewModel.images?[indexPath.row].descriptionPost ?? "error",
                image: viewModel.images?[indexPath.row].image ?? "error",
                likes: viewModel.images?[indexPath.row].likes ?? 0,
                views: viewModel.images?[indexPath.row].views ?? 0)
        )
        tableView.reloadData() 
    }
    

}

