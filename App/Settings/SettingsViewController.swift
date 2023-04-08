//
//  SettingsViewController.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit
protocol SettingsViewControllerDelegate: AnyObject {
    func settingsViewControllerDidUpdateSortOrder(isSorted: Bool)
}
class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: SettingsViewControllerDelegate?
    let passwordKeychainService = KeychainSevice()
    weak var coordinator: SettingsCoordinator?
    var isSorted = UserDefaults.standard.bool(forKey: "sort")
    
    let table: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.addSubview(buttonChangePassword)
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            buttonChangePassword.topAnchor.constraint(equalTo: table.topAnchor,constant: 200),
            buttonChangePassword.centerXAnchor.constraint(equalTo: table.centerXAnchor),
            buttonChangePassword.widthAnchor.constraint(equalToConstant: 200),
            buttonChangePassword.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.textColor = .black
        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row
        // смена названия
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        if isSorted == true {
            cell.textLabel?.text = "Sort A to Z"
            switchView.setOn(true, animated: true)
        } else {
            cell.textLabel?.text = "Sort Z to A"
            switchView.setOn(false, animated: true)
        }
        return cell
    }
    // меняем пароль
    private lazy var buttonChangePassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Поменять пароль", for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Pink")
        return button
    }()
    @objc func buttonTap() {
        // обновляем пароль
        let passwordVC = PasswordViewController(updatePassword: true)
        passwordVC.modalPresentationStyle = .automatic
        present(passwordVC, animated: true, completion: nil)
    }

    @objc func switchChanged(_ sender: UISwitch!) {
        // переключение sender
        isSorted = sender.isOn
        UserDefaults.standard.set(isSorted, forKey: "sort")
        table.reloadData()
        // отправляем флаг сортировки
        delegate?.settingsViewControllerDidUpdateSortOrder(isSorted: isSorted)
    }
}



