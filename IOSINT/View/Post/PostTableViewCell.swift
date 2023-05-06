//
//  PostTableViewCell.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.contentMode = .scaleAspectFit
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var decriptionLabel: UILabel = {
        let decriptionLabel = UILabel()
        decriptionLabel.lineBreakMode = .byWordWrapping
        decriptionLabel.numberOfLines = 0
        decriptionLabel.textAlignment = .justified
        decriptionLabel.contentMode = .scaleAspectFit
        decriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return decriptionLabel
    }()
    
    
    
    lazy var labelLikes: UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var labelViews: UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(with post: PostEntity) {
        titleLabel.text = post.author
        decriptionLabel.text = post.descriptionPost
        labelLikes.text = "Likes: \(post.likes)"
        labelViews.text = "Views:\(post.views)"
        decriptionLabel.textColor = .darkGray
        myImageView.image = UIImage(named:"\(post.image ?? "logo.png"))")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    var post: PostStorage? {
        didSet {
            titleLabel.text = post?.author
            decriptionLabel.text = post?.descriptionPost
            labelLikes.text = "Likes: \(post?.likes ?? 33)"
            labelViews.text = "Views:\(post?.views ?? 33)"
            decriptionLabel.textColor = .darkGray
            myImageView.image = UIImage(named:"\(post?.image ?? "2"))")
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
    func setupView() {
        contentView.addSubview(myImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelLikes)
        contentView.addSubview(labelViews)
        contentView.addSubview(decriptionLabel)
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            myImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            myImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            myImageView.heightAnchor.constraint(equalToConstant:450),
            
            
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            decriptionLabel.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor,constant: 8),
            decriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            decriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            labelLikes.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -16),
            labelLikes.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            labelLikes.heightAnchor.constraint(equalToConstant: 18),
            labelLikes.widthAnchor.constraint(equalToConstant: 100),
            
            labelViews.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant:-16),
            labelViews.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            labelViews.heightAnchor.constraint(equalToConstant: 18),
            labelViews.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
}

