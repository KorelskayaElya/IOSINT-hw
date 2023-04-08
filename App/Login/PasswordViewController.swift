//
//  PasswordViewController.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

final class PasswordViewController: UIViewController {
    
    var passwordFirst: String?
    var passwordSecond: String?
    var savedPassword: String?
    let passwordKeychainService = KeychainSevice()
    var updatePassword: Bool
    weak var coordinator: CoordinatbleLogin?
    var personView: UIView!
    var headLayer: CAShapeLayer!
    var startTime: CFTimeInterval = 0
    
    // пользовательский инициализатор
    init(updatePassword: Bool) {
        self.updatePassword = updatePassword
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Создаем UIView для смайлика
        personView = UIView(frame: CGRect(x: 120, y: 100, width: 150, height: 150))
        view.addSubview(personView)

        // Создаем круглую форму для головы
        let headPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 150, height: 150))

        // Создаем CAShapeLayer для формы головы
        let headLayer = CAShapeLayer()
        headLayer.path = headPath.cgPath
        headLayer.strokeColor = UIColor.black.cgColor
        headLayer.fillColor = UIColor(red: 255/255, green: 222/255, blue: 173/255, alpha: 1.0).cgColor
        headLayer.lineWidth = 4

        // Добавляем CAShapeLayer в UIView
        personView.layer.addSublayer(headLayer)

        // Создаем глаза
        let leftEye = UIView(frame: CGRect(x: 40, y: 45, width: 20, height: 20))
        leftEye.backgroundColor = .white
        leftEye.layer.cornerRadius = 10
        leftEye.layer.borderWidth = 2
        leftEye.layer.borderColor = UIColor.black.cgColor
        personView.addSubview(leftEye)

        let rightEye = UIView(frame: CGRect(x: 90, y: 45, width: 20, height: 20))
        rightEye.backgroundColor = .white
        rightEye.layer.cornerRadius = 10
        rightEye.layer.borderWidth = 2
        rightEye.layer.borderColor = UIColor.black.cgColor
        personView.addSubview(rightEye)
        
        let leftPupil = UIView(frame: CGRect(x: 7, y: 5, width: 10, height: 10))
        leftPupil.backgroundColor = .black
        leftPupil.layer.cornerRadius = 5
        leftEye.addSubview(leftPupil)

        let rightPupil = UIView(frame: CGRect(x: 7, y: 5, width: 10, height: 10))
        rightPupil.backgroundColor = .black
        rightPupil.layer.cornerRadius = 5
        rightEye.addSubview(rightPupil)

        
        // Создаем рот
        let mouthPath = UIBezierPath()
        mouthPath.move(to: CGPoint(x: 50, y: 90))
        mouthPath.addQuadCurve(to: CGPoint(x: 100, y: 90), controlPoint: CGPoint(x: 75, y: 120))


        let mouthLayer = CAShapeLayer()
        mouthLayer.path = mouthPath.cgPath
        mouthLayer.fillColor = UIColor.clear.cgColor
        mouthLayer.strokeColor = UIColor.black.cgColor
        mouthLayer.lineWidth = 4
        personView.layer.addSublayer(mouthLayer)

        // Создаем анимацию для рта
        let mouthAnimation = CABasicAnimation(keyPath: "path")
        mouthAnimation.fromValue = mouthPath.cgPath
        mouthAnimation.duration = 2.0
        mouthAnimation.autoreverses = true
        mouthAnimation.repeatCount = .infinity

        // Изменяем координаты точек пути для улыбки
        let smilePath = UIBezierPath()
        smilePath.move(to: CGPoint(x: 40, y: 100))
        smilePath.addQuadCurve(to: CGPoint(x: 110, y: 100), controlPoint: CGPoint(x: 75, y: 80))

        mouthAnimation.toValue = smilePath.cgPath

        // Анимация для моргания
        let blinkAnimation = CABasicAnimation(keyPath: "opacity")
        blinkAnimation.fromValue = 1.0
        blinkAnimation.toValue = 0.0
        blinkAnimation.duration = 0.2
        blinkAnimation.autoreverses = true
        blinkAnimation.repeatCount = 1

        // Анимация для губ
        let poutPath = UIBezierPath()
        poutPath.move(to: CGPoint(x: 40, y: 140))
        poutPath.addQuadCurve(to: CGPoint(x: 160, y: 140), controlPoint: CGPoint(x: 100, y: 160))
        mouthLayer.add(mouthAnimation, forKey: "animateMouth")
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        passwordTextField.text = nil
        passwordFirst = nil
        passwordSecond = nil
        savedPassword = nil
        
        if passwordKeychainService.retrivePassword(credentials: Credentials.init(password: "")).status == errSecItemNotFound || updatePassword == true {
            passwordDeleteBtn.isEnabled = false
            passwordBtn.setTitle("Создать пароль", for: .normal)
            passwordBtn.addTarget(self, action: #selector(firstPasswordEnter), for: .touchUpInside)
            view.reloadInputViews()
        } else {
            passwordBtn.setTitle("Введите пароль", for: .normal)
            passwordBtn.addTarget(self, action: #selector(firstPasswordEnter), for: .touchUpInside)
        }

    }
    @objc private func firstPasswordEnter() {
        guard let text = passwordTextField.text, !text.isEmpty, text.count >= 4  else {
            TemplateErrorAlert.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Необходимо 4 символа")
            return
        }
        passwordFirst = text
        passwordTextField.text = nil
        passwordBtn.removeTarget(self, action: #selector(firstPasswordEnter), for: .touchUpInside)
        passwordBtn.setTitle("Повторите пароль", for: .normal)
        passwordBtn.addTarget(self, action: #selector(repeatPassword), for: .touchUpInside)
    }

    @objc private func repeatPassword() {
        guard let text = passwordTextField.text, !text.isEmpty, text.count >= 4 else {
            TemplateErrorAlert.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Необходимо 4 символа")
            return
        }
        passwordSecond = text
        guard passwordFirst == passwordSecond else {
            passwordBtn.removeTarget(self, action: #selector(repeatPassword), for: .touchUpInside)
            TemplateErrorAlert.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Пароли не совпадают")
            viewWillAppear(true)
            return
        }
        switch savedPassword {
        case nil:
            if updatePassword == true {
                passwordKeychainService.updatePassword(credentials: Credentials.init(password: text))
                dismiss(animated: true, completion: {
                    TemplateErrorAlert.shared.alert(alertTitle: "Пароль обновлён", alertMessage: "Ваш пароль обновлён в Keychain")
                })

            } else {
            passwordKeychainService.savePassword(credentials: Credentials.init(password: text))
            coordinator?.switchToTabBarCoordinator()
            TemplateErrorAlert.shared.alert(alertTitle: "Пароль создан", alertMessage: "Ваш пароль создан и сохранён в Keychain")
            }
        case passwordSecond:
            coordinator?.switchToTabBarCoordinator()
        default:
            passwordBtn.removeTarget(self, action: #selector(repeatPassword), for: .touchUpInside)
            TemplateErrorAlert.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Пароль не найден")
            viewWillAppear(true)
        }
    }
    @objc private func deletePassword() {
        passwordKeychainService.deletePassword(credentials: Credentials.init(password: ""))
        TemplateErrorAlert.shared.alert(alertTitle: "Пароль удалён", alertMessage: "Ваш пароль удалён из Keychain")
        viewWillAppear(true)
    }

    // поле ввода пароля
    lazy var passwordTextField: UITextField = {
       let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(text: "Password", aligment: .center, color: .black)
        text.font = UIFont(name:"Times New Roman", size: 50.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 4.0
        text.layer.cornerRadius = 20
        text.layer.borderColor = UIColor.black.cgColor
        text.isSecureTextEntry = true
        return text
    }()
    // кнопка входа в приложение
    lazy var passwordBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let passwordDeleteBtn: UIButton = {
       let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.setTitle("Удалить пароль", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deletePassword), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    // настройка вью
    func setupView() {
        view.addSubview(passwordTextField)
        view.addSubview(passwordBtn)
        //view.addSubview(imageDog)
        view.addSubview(passwordDeleteBtn)
        NSLayoutConstraint.activate([
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
            
            
            // кнопка удаления пароля
            passwordDeleteBtn.topAnchor.constraint(equalTo: passwordBtn.bottomAnchor, constant: 5),
            passwordDeleteBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordDeleteBtn.heightAnchor.constraint(equalToConstant: 50),
            passwordDeleteBtn.widthAnchor.constraint(equalToConstant: 200),
    
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
