//
//  PaaswordViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 02.03.2023.
//

import UIKit
// это все отображалось, но я пытаюсь в Launch Screen (превью) с аутентификацией положить
class PasswordViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Pink")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        passwordBtn.setTitle("Create password", for: .normal)
        passwordBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)

    }
    
    var updatePassword: Bool
    
    init(updatePassword: Bool) {
        self.updatePassword = updatePassword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var imageDog: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dog")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var passwordTextField: UITextField = {
       let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(text: "Password", aligment: .center, color: .black)
        text.font = UIFont(name:"Times New Roman", size: 50.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 4.0
        text.layer.borderColor = UIColor.black.cgColor
        text.isSecureTextEntry = true
        return text
    }()
    
    lazy var passwordBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    func setupView() {
        view.addSubview(passwordTextField)
        view.addSubview(passwordBtn)
        view.addSubview(imageDog)
        NSLayoutConstraint.activate([
            // поле для ввода пароля
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 80),
            // кнопка перехода с аутентификации дальше по навигации
            passwordBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordBtn.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordBtn.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordBtn.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordBtn.heightAnchor.constraint(equalToConstant: 80),
            // просто картиночка
            imageDog.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageDog.widthAnchor.constraint(equalToConstant: 200),
            imageDog.heightAnchor.constraint(equalToConstant: 200),
            imageDog.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    
        ])
    }

}
extension NSAttributedString{
    convenience init(text: String, aligment: NSTextAlignment, color:UIColor) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor:color])
    }
}
