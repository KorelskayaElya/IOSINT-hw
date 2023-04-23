//
//  VideoViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 15.02.2023.
//

import UIKit
import AVFoundation

struct videoItem {
    let title: String
    let link: String
}

class VideoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    private var list = [videoItem]()
    
    private let videoPlayer: AVPlayer = {
        return AVPlayer()
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: videoPlayer)
        return layer
    }()
    
    private lazy var playerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.addSublayer(playerLayer)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "Pink")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = playerView.bounds
    }
    
    @objc private func goToRecorder() {
        videoPlayer.pause()
        coordinator?.toRecorder()
    }
    
    private func startVideo(numberOfVideo: Int) {
        videoPlayer.replaceCurrentItem(with: AVPlayerItem(url: URL(string: list[numberOfVideo].link)!))
        videoPlayer.play()
    }
    
    
    private func addVideoItems() {
        list.append(videoItem(title: "Funny video", link: "https://customer-t650oxmd7oj07ex3.cloudflarestream.com/c555e8058fac3c3442ad2229783642ae/manifest/video.m3u8"))
        list.append(videoItem(title: "Super funny", link: "https://customer-t650oxmd7oj07ex3.cloudflarestream.com/180485a8b80743f029b184bc70f3f592/manifest/video.m3u8"))
        list.append(videoItem(title: "Best video", link: "https://customer-t650oxmd7oj07ex3.cloudflarestream.com/382d37f21eb1719f9a048e9c6329bc8c/manifest/video.m3u8"))
        list.append(videoItem(title: "Video cool", link: "https://customer-t650oxmd7oj07ex3.cloudflarestream.com/1fbbb66c0a3ee51ba6e637bc631484c0/manifest/video.m3u8"))
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recorder", style: .plain, target: self, action: #selector(goToRecorder))
        
        view.backgroundColor = UIColor(named: "Pink")
        view.addSubview(playerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.625),
            
            tableView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Video zone"
        setupViews()
        addVideoItems()
        playerView.layoutIfNeeded()
    }
}


extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        cell.backgroundColor = UIColor(named: "Pink")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoPlayer.pause()
        startVideo(numberOfVideo: indexPath.row)
    }
}

