//
//  PasswordViewController.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit
import RealmSwift

final class PasswordViewController: UIViewController {
    
    var modalFlag = false
    weak var coordinator: CoordinatbleLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        loginTextField.text = nil
        passwordTextField.text = nil
        print("modelflag -", modalFlag)
        // если открыт модальный экран - скрыть кнопку войти и зарегистрироваться,
        // открыть кнопку сменить пароль
        if modalFlag == true {
            changeBtn.isHidden = false
            registerBtn.isHidden = true
            passwordBtn.isHidden = true
            closeBtn.isHidden = false
        } else {
            changeBtn.isHidden = true
            registerBtn.isHidden = false
            passwordBtn.isHidden = false
            closeBtn.isHidden = true
        }

    }
    @objc func closeButtonTapped() {
        // Закрыть модальное окно
        dismiss(animated: true, completion: nil)
    }
    /// перенести в другой файл
    func loginUser(username: String, password: String) {
        let realm = try? Realm()
        let users = realm?.objects(User.self).filter("username = '\(username)' AND password = '\(password)'")
        if let user = users?.first {
            coordinator?.switchToTabBarCoordinator()
        } else {
            TemplateErrorAlert.shared.alert(alertTitle: "Неверный логин или пароль", alertMessage: "Попробуйте снова")
        }
    }
    // войти в приложение
    @objc func enterInApp(_ sender: Any) {
        let username = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        loginUser(username: username, password: password)
    }
    // изменить пароль
    @objc func changePassword(_ sender: Any) {
        let username = loginTextField.text ?? ""
        let newpassword = passwordTextField.text ?? ""
        updatePassword(username: username, newPassword: newpassword)
    }
    /// перенести в другой файл
    func updatePassword(username: String, newPassword: String) {
        let realm = try? Realm()
        if let user = realm?.objects(User.self).filter("username = '\(username)'").first {
            try? realm?.write {
                if !user.password.isEmpty && user.password.count >= 4 {
                    user.password = newPassword
                    TemplateErrorAlert.shared.alert(alertTitle: "Пароль пользователя \(username) изменен", alertMessage: "Хорошего дня")
                } else {
                    TemplateErrorAlert.shared.alert(alertTitle: "Необходимо задать больше 4 символов", alertMessage: "Попробуйте еще раз")
                }
            }
        } else {
            TemplateErrorAlert.shared.alert(alertTitle: "Пользователь \(username) не найден", alertMessage: "Попробуйте еще раз")
        }
    }
    // зарегистрироаться
    @objc func registerUser() {
        let realm = try? Realm()
        let user = User()
        user.username = loginTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        if user.username == "" || user.username.count < 4 {
            TemplateErrorAlert.shared.alert(alertTitle: "Что-то не так...", alertMessage: "Введите в поле логина больше 4 символов")
        }
        if user.password == "" || user.password.count < 4 {
            TemplateErrorAlert.shared.alert(alertTitle: "Что-то не так...", alertMessage: "Введите в поле пароля больше 4 символов")
        }
       
        if !user.username.isEmpty && !user.password.isEmpty && user.username.count >= 4 && user.password.count >= 4 {
            try? realm?.write {
                realm?.add(user)
                TemplateErrorAlert.shared.alert(alertTitle: "Вы зарегистрированы", alertMessage: "Войдите в приложение")
            }
        }
    }
    // поле ввода логина
    lazy var loginTextField: UITextField = {
       let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(text: "Login", aligment: .center, color: .black)
        text.font = UIFont(name:"Times New Roman", size: 25.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 2.0
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.black.cgColor
        text.isSecureTextEntry = false
        return text
    }()

    // поле ввода пароля
    lazy var passwordTextField: UITextField = {
       let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(text: "Password", aligment: .center, color: .black)
        text.font = UIFont(name:"Times New Roman", size: 25.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 2.0
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.black.cgColor
        text.isSecureTextEntry = true
        return text
    }()
    // кнопка входа в приложение
    lazy var passwordBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Pink")
        button.layer.cornerRadius = 20
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(enterInApp), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    // кнопка закрытия модального экрана
    lazy var closeBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    // кнопка для регистрации
    lazy var registerBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Pink")
        button.layer.cornerRadius = 20
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    // кнопка для смены пароля
    lazy var changeBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Pink")
        button.layer.cornerRadius = 20
        button.setTitle("Сменить пароль", for: .normal)
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    // настройка вью
    func setupView() {
        view.addSubview(passwordTextField)
        view.addSubview(passwordBtn)
        view.addSubview(loginTextField)
        view.addSubview(registerBtn)
        view.addSubview(changeBtn)
        view.addSubview(closeBtn)
        NSLayoutConstraint.activate([
            // поле для ввода логина
            loginTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -150),
            loginTextField.widthAnchor.constraint(equalToConstant: 250),
            loginTextField.heightAnchor.constraint(equalToConstant: 60),
            
            // поле для ввода пароля
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -90),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            // кнопка перехода с аутентификации дальше по навигации
            passwordBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordBtn.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordBtn.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordBtn.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordBtn.heightAnchor.constraint(equalToConstant: 80),
            
            registerBtn.topAnchor.constraint(equalTo: passwordBtn.bottomAnchor, constant: 5),
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerBtn.heightAnchor.constraint(equalToConstant: 50),
            registerBtn.widthAnchor.constraint(equalToConstant: 200),
            
            changeBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            changeBtn.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            changeBtn.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            changeBtn.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            changeBtn.heightAnchor.constraint(equalToConstant: 50),
            
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeBtn.widthAnchor.constraint(equalToConstant: 50),
            closeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            closeBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}
// расширение для текста
extension NSAttributedString{
    convenience init(text: String, aligment: NSTextAlignment, color:UIColor) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor:color])
    }
}
