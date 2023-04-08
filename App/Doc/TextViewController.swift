//
//  TextViewController.swift
//  App
//
//  Created by Эля Корельская on 08.04.2023.
//

import UIKit
// вью с текстом
class TextViewController: UIViewController {
    
    private let fileContents: String
    var shareButton: UIBarButtonItem!
    
    init(fileContents: String) {
        self.fileContents = fileContents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Text file"
        // Добавить кнопку "Поделиться"
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = shareButton
        
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = fileContents
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    @objc func shareButtonTapped() {
        //let url = NSURL(string: "data:text/plain;charset=utf-8," + self.fileContents)!
        let activityViewController = UIActivityViewController(activityItems: [self.fileContents], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = shareButton
        present(activityViewController, animated: true, completion: nil)
    }
}

