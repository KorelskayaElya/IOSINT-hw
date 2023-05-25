//
//  PhotosViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    // обновление информации
    var viewModel: PhotoViewModel! {
        didSet {
            self.viewModel.photoChange = { [ weak self ] viewModel in
                self?.setupThread(images: viewModel.photoNames)
            }
        }
    }
    // создаем пустой массив
    private var recivedImages: [UIImage] = []
    // создаем экземпляр класса ImagePublisherFacade
    //private let imageFasade = ImagePublisherFacade()
    
    private lazy var flowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.size.width - 40) / 3, height: (self.view.frame.size.width - 40) / 3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()
    private lazy var collection: UICollectionView = {
        let myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        myCollectionView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        myCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        return myCollectionView
    }()
    // индикатор загрузки изображений
    private lazy var activityIndicator: UIActivityIndicatorView = {
         var activityIndicator = UIActivityIndicatorView(style: .large)
         activityIndicator.hidesWhenStopped = true
         activityIndicator.startAnimating()
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         return activityIndicator
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigationBar()
        viewModel?.photoAdd()
        self.runTimer()
    }
    private func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if !self.recivedImages.isEmpty {
                // остановка индикатора
                self.activityIndicator.stopAnimating()
                // отключение таймера
                timer.invalidate()
                // обновление коллекции
                self.collection.reloadData()
            }
        }
    }
    /*
     Замер скорости обработки изображений
     QoS:
     .utility         : 1.4942
     .userInteractive : 1.3657 - быстрее остальных
     .userInitiated   : 1.4037
     .default         : 1.3988
     .background      : 5.702 - дольше остальных
     */
    private func setupThread(images: [String]?) {
        var photo = [UIImage]()
        guard let array = images else { return }
        //        array.forEach {i in photo.append(UIImage(named: i)!)}
        //        imageFasade.subscribe(self)
        //        self.imageFasade.addImagesWithTimer(time: 0.7, repeat: 35, userImages: photo)
        
        array.forEach { photo.append(UIImage(named: $0)!) }
        
        let imageProcessor = ImageProcessor()
        let start = CFAbsoluteTimeGetCurrent()
        imageProcessor.processImagesOnThread(sourceImages: photo,
                                             filter: .fade,
                                             qos: .utility) { cgImage in
            let diff = CFAbsoluteTimeGetCurrent() - start
            cgImage.forEach {
                guard let image = $0 else {return }
                self.recivedImages.append(UIImage(cgImage: image))
            }
            
            print("Took \(diff) seconds")
//            DispatchQueue.main.async {
//                self.collection.reloadData()
//            }
        }
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        // отписываемся
//        imageFasade.removeSubscription(for: self)
//    }
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.collection)
        self.view.addSubview(self.activityIndicator)
    
        NSLayoutConstraint.activate([
            self.collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Photo Gallery".localized
    
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
extension PhotosViewController: UICollectionViewDataSource,  UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recivedImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return mycell
        }
        let imageName = recivedImages[indexPath.row]
        myCell.setupCell(with: imageName)
        return myCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
    
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        recivedImages = images
        collection.reloadData()
    }
}
