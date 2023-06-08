//
//  LogInViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    // private var delegate: LogInViewControllerDelegate?
    weak var coordinator: ProfileCoordinator?
    // обновление информации
    //        var viewModel: LogInViewModel! {
    //            didSet {
    //                self.viewModel.checker = { [ weak self ] viewModel in
    //                    guard let logInedUser = viewModel.logInedUser else {
    //                        //self?.showAlert()
    //                        preconditionFailure("nil user")
    //                    }
    //                   self?.coordinator?.goToProfileViewController(with: logInedUser)
    //                }
    //            }
    //        }
    var checkerService: CheckerServiceProtocol?
    @objc func buttonPressLog() {
        guard let login = loginTextField.text, let pass = passwordTextField.text, !login.isEmpty, !pass.isEmpty else {
            TemplateErrorAlert.shared.alert(alertTitle: NSLocalizedString("Ошибка заполнения", comment: ""), alertMessage: NSLocalizedString("Заполните пустые поля", comment: ""))
            return
        }
        checkerService?.checkCredentials(login: login, password: pass) { workingDone in
            // сюда не заходит
            if workingDone {
                print("goToProfileViewController")
                self.coordinator?.goToProfileViewController()
            } else {
                print("login error")
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        //self.scrollView.addSubview(self.bruteForceButton)
        // self.bruteForceButton.addSubview(activityIndicator)
        self.contentView.addSubview(self.textFieldStackView)
        self.contentView.addSubview(self.buttonLog)
        self.contentView.addSubview(self.logView)
        self.textFieldStackView.addArrangedSubview(self.loginTextField)
        self.textFieldStackView.addArrangedSubview(self.passwordTextField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.contraintsLog()
        self.setupGesture()
    }
    //скролл
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    // контент
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // логотип
    private lazy var logView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        return imageView
        
    }()
    // стек для ввода логина пароля
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // логин
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.text = "kov@mail.ru"
        textField.placeholder = " Email of phone".localized
        return textField
    }()
    // пароль
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.autocapitalizationType = .none
        textField.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.text = "1234567"
        textField.placeholder = " Password".localized
        return textField
    }()
    // кнопка
    private lazy var buttonLog: UIButton = {
           let button = UIButton()
           let image = UIImage(named: "blue_pixel")
           button.setBackgroundImage(image,for: UIControl.State.normal)
           button.setTitleColor(.white, for: .normal)
           button.setTitle("Log in".localized, for: .normal)
           button.layer.cornerRadius = 10
           button.translatesAutoresizingMaskIntoConstraints = false
           button.clipsToBounds = true
           button.addTarget(self, action: #selector(buttonPressLog), for: .touchUpInside)
           return button
       }()
    
    private func contraintsLog() {
        NSLayoutConstraint.activate([
            //логотип
            logView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 120),
            logView.widthAnchor.constraint(equalToConstant: 100),
            logView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor),
            logView.heightAnchor.constraint(equalToConstant: 100),
            //scrollview
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            //contentview
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1.0),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            //stack
            textFieldStackView.topAnchor.constraint(equalTo: self.logView.bottomAnchor,constant: 120),
            textFieldStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -16),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 100),
            textFieldStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            //button
            buttonLog.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor,constant: 16),
            buttonLog.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -16),
            buttonLog.heightAnchor.constraint(equalToConstant: 50),
            buttonLog.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            buttonLog.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
    }
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDisappear))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginTextField.becomeFirstResponder()
    }
    
    private let notification = NotificationCenter.default
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true //прячем NavigationBar
        notification.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height + 50
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    @objc private func keyboardDisappear() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
        self.view.endEditing(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        notification.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // при нажатии на кнопку должны обработаться два метода
    //    @objc private func buttonPressLog() {
    //        view.endEditing(true)
    //        do {
    ////            try viewModel.startChecker(login: loginTextField.text!, pass: passwordTextField.text!)
    //        } catch LogInErrors.emptyLogin {
    //            TemplateErrorAlert.shared.alert(alertTitle: "Ошибка заполнения".localized, alertMessage: "Заполните пустые поля".localized)
    //        } catch LogInErrors.emptyPassword {
    //            TemplateErrorAlert.shared.alert(alertTitle: "Ошибка заполнения".localized, alertMessage: "Заполните пустые поля".localized)
    //        } catch {}
}
