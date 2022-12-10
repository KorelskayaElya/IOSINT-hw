//
//  ProfileTableHeaderView.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import SnapKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText : String = ""
    
    struct ViewModel {
        let name: String
        let description: String
        let image: UIImage?
    }
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "cat_image")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 55
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Courier New", size: 24)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        return button
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "Courier New", size: 15)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.placeholder = "Set your status ..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(self.statusTextChanged(_:)), for:.editingChanged)
        return textField
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.contraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: ViewModel) {
        self.avatarImageView.image = UIImage(named: "cat_image")
        self.nameLabel.text = viewModel.name
        self.nameLabel.font = UIFont(name: "Courier New", size: 18)
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.descriptionLabel.text = viewModel.description
        self.descriptionLabel.textColor = .darkGray
        self.descriptionLabel.font = UIFont(name: "Courier New", size: 14)
    }
    
    private func setupView() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.button)
        self.addSubview(self.nameLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.textField)
   }
    private func contraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(110)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.equalTo(avatarImageView.snp.leading).offset(140)
            make.width.equalTo(217)
            make.height.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.leading.equalTo(avatarImageView.snp.leading).offset(140)
            make.height.equalTo(20)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(96)
            make.leading.equalTo(avatarImageView.snp.leading).offset(136)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    @objc func buttonPressed() {
        let status : String? = self.descriptionLabel.text
        print(status ?? "hi")
        descriptionLabel.text = self.statusText
        
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = self.textField.text ?? "nil"
        print(statusText)
    }
    

       
}

