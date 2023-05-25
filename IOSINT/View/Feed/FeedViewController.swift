//
//  FeedViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit

class FeedViewController: UIViewController {

    weak var coordinator: FeedCoordinator?
    private lazy var button = CustomButton(customButtonTitle: "Click".localized) {
        self.tapButton()
    }
    // проверка введенного слова
    private var checkLabel: UILabel = {
           let label = UILabel()
           label.text = "0000"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    // проверка пароля 0000 с цветовой индикацией
    private lazy var checkGuessButton = CustomButton(customButtonTitle: "Check".localized) {
        guard let checkedSecret = self.textField.text else { return }
        if !checkedSecret.isEmpty {
            if FeedModel().check(secretWord: checkedSecret) {
            self.checkLabel.text = "1234"
            self.checkLabel.textColor = .green
            } else {
                self.checkLabel.textColor = .red
                self.checkLabel.text = "Wrong password".localized
                    }
                } else {
                    // проверка на пустое значение
                    print("String is Empty")
                }
    }
    private var textField: UITextField = {
        let text = UITextField()
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        text.text = "0000"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private lazy var avButton = CustomButton(customButtonTitle: "AVPlayer".localized) {
         self.goToAVPlayer()
     }
    private func goToAVPlayer() {
        coordinator?.toAVPlayer()
     }
    private lazy var infoBtn = CustomButton(customButtonTitle: "Info".localized) {
         self.goToInfo()
     }
    private func goToInfo() {
        coordinator?.toInfo()
     }


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed".localized
        view.backgroundColor = .systemIndigo
        view.addSubview(self.button)
        view.addSubview(self.textField)
        view.addSubview(self.checkLabel)
        view.addSubview(self.checkGuessButton)
        view.addSubview(self.avButton)
        view.addSubview(self.infoBtn)
        NetworkService.request(for: appConfiguration!)
        self.setupConstraints()
    }
    private func tapButton() {
        coordinator?.goToPostViewController()
    }
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            checkLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 22),
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            checkGuessButton.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 200),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            avButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avButton.heightAnchor.constraint(equalToConstant: 40),
            avButton.widthAnchor.constraint(equalToConstant: 200),
            avButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            
            infoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoBtn.heightAnchor.constraint(equalToConstant: 40),
            infoBtn.widthAnchor.constraint(equalToConstant: 200),
            infoBtn.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
        
            
                       
        ])
    }
}
