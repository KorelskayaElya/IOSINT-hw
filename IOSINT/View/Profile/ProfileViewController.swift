//
//  ProfileViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import StorageService
import FirebaseAuth
import FirebaseCore

class ProfileViewController: UIViewController {
    let GroupSection = ["Photos","---"]
    
    var newUser: User? = nil
    weak var coordinator: ProfileCoordinator?
    private var images = [Post]()
    // обновление информации
    var viewModel: ProfileViewModel! {
        didSet {
            self.viewModel.userChange = { [ weak self ] viewModel in
                self?.newUser = viewModel.user ?? nil
                self?.images = viewModel.images ?? []
            }
        }
    }
    
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
            return PostStorage.post.count
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
            let images = PostStorage.post[indexPath.row]
            cell.setup(with: images)
            return cell
        }
    }

}

