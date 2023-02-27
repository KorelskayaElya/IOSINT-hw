//
//  LogInViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    // LoginViewController имеет ссылку на LoginInspector в виде приватного свойства
    private var delegate: LogInViewControllerDelegate?
    weak var coordinator: ProfileCoordinator?
        // обновление информации
        var viewModel: LogInViewModel! {
            didSet {
                self.viewModel.checker = { [ weak self ] viewModel in
                    guard let logInedUser = viewModel.logInedUser else {
                        //self?.showAlert()
                        preconditionFailure("nil user")
                    }
                    self?.coordinator?.goToProfileViewController(with: logInedUser)
                }
            }
        }
    //    // обновление информации
    //    var bruteForceViewModel: BruteForceViewModel! {
    //             didSet {
    //                 self.bruteForceViewModel.passwordFound = { [weak self] bruteForceViewModel in
    //                     // асинхронный поток
    //                     DispatchQueue.main.async {
    //                         //self?.bruteForceButton.isEnabled = true
    //                         // скрывать загрузку
    //                        // self?.hideLoading()
    //                         // вставлять подобранный предполагаемый пароль
    //                         self?.passwordTextField.isSecureTextEntry = false
    //                         self?.passwordTextField.text = bruteForceViewModel.brutedPassword
    //                     }
    //
    //                 }
    //             }
    //         }
    
    private func setupView() {
        view.backgroundColor = .white
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
    //контент
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    //логотип
    private lazy var logView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        return imageView
        
    }()
    //стек для ввода логина пароля
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
    //логин
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named:"AccentColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.text = "123"
        textField.placeholder = " Email of phone"
        return textField
    }()
    //пароль
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named:"AccentColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.text = "123"
        textField.placeholder = " Password"
        return textField
    }()
    //кнопка
    private lazy var buttonLog: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "blue_pixel")
        button.setBackgroundImage(image,for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonPressLog), for: .touchUpInside)
        return button
    }()
    //    // индикатор загрузки
    //    private lazy var activityIndicator: UIActivityIndicatorView = {
    //        var activityIndicator = UIActivityIndicatorView(style: .large)
    //            activityIndicator.hidesWhenStopped = true
    //            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    //            return activityIndicator
    //        }()
    //    // кнопка перебра паролей
    //    private lazy var bruteForceButton: UIButton = {
    //        let button = UIButton()
    //        let image = UIImage(named: "blue_pixel")
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.setTitle("Подобрать пароль", for: .normal)
    //        button.setTitleColor(UIColor.black, for: .normal)
    //        button.layer.borderWidth = 2
    //        button.layer.borderColor = UIColor.black.cgColor
    //        button.addTarget(self, action: #selector(startBruteForce), for: .touchUpInside)
    //        button.layer.cornerRadius = 15
    //        button.clipsToBounds = true
    //        button.setBackgroundImage(image,for: UIControl.State.normal)
    //        return button
    //    }()
    
    
    //    // начать перебор паролей
    //    @objc private func startBruteForce() {
    //        bruteForceButton.isEnabled = false
    //        showLoading()
    //        bruteForceViewModel.StartBrute()
    //     }
    //    // показывать загрузку
    //    func showLoading() {
    //        bruteForceButton.setTitle("", for: .normal)
    //        activityIndicator.isHidden = false
    //        activityIndicator.startAnimating()
    //    }
    //    // скрывать загрузку
    //    func hideLoading() {
    //        bruteForceButton.setTitle("Подобрать пароль", for: .normal)
    //        activityIndicator.stopAnimating()
    //    }
    
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
            
            //            bruteForceButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 80),
            //            bruteForceButton.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor, constant: 60),
            //            bruteForceButton.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor, constant: -60),
            //            bruteForceButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            //            activityIndicator.centerYAnchor.constraint(equalTo: bruteForceButton.centerYAnchor),
            //            activityIndicator.centerXAnchor.constraint(equalTo: bruteForceButton.centerXAnchor),
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
    @objc private func buttonPressLog() {
        view.endEditing(true)
        // если не пусто 
        guard let login = self.loginTextField.text, let pass = self.passwordTextField.text, !login.isEmpty, !pass.isEmpty else {
            // пусто
            TemplateErrorAlert.shared.alert(alertTitle: "Ошибка заполнение", alertMessage: "Заполните пустые поля")
            return
        }
        // если авторизация прошла открываем вью
        if self.delegate?.check(login: login, password: pass) == true {
            self.coordinator?.start()
        } else {
            return
        }
    }
}
    
    
