//
//  MusicViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 15.02.2023.
//

import UIKit
import AVFoundation
// структура трека
struct track {
    let name: String
    let artist: String
    let trackName: AVPlayerItem
}
// прослушивание треков
class MusicViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    var playTrack: [track] = []
    var isRepeat: Bool = false
    var isTapped: Bool = true
    
    private let player: AVPlayer = {
        return AVPlayer()
    }()
    
    private lazy var audioView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "music"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.addArrangedSubview(backButton)
        stack.addArrangedSubview(playButton)
        stack.addArrangedSubview(stopButton)
        stack.addArrangedSubview(forwardButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(playBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(stopBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backTrack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(repeatBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var titleOfSong: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc private func nextTrack() {
        forward()
    }
    @objc private func backTrack() {
        backward()
    }
    @objc private func repeatBtn() {
        if isTapped == true {
            isRepeat = true
            repeatButton.setImage(UIImage(systemName: "repeat.1.ar"), for: .normal)
            isTapped = false
        } else {
            isTapped = true
            isRepeat = false
            repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        }
    }
    @objc private func repeatAllTracksBtn() {
        isRepeat = false
    }
    @objc private func playBtn() {
        if player.currentItem != nil {
            if player.isPlaying {
                pause()
            } else {
                play()
            }
        } else {
            player.replaceCurrentItem(with: playTrack[0].trackName)
            titleOfSong.text = playTrack[0].artist + " - " + playTrack[0].name
            play()
        }
    }
    @objc private func stopBtn() {
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        pause()
    }
    // проигрывание
    func play() {
        player.play()
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    // пауза
    func pause() {
        player.pause()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    // следующий трек
    func forward() {
        guard let item = player.currentItem else {
            print("tracklist is empty")
            return
        }
        var index: Int = 0
        for (trackIndex, trackName) in playTrack.enumerated() {
            if trackName.trackName == item {
                index = trackIndex
            }
        }
        if index < playTrack.count - 1 {
            player.replaceCurrentItem(with: playTrack[index+1].trackName)
            titleOfSong.text = playTrack[index+1].artist + " - " + playTrack[index+1].name
            player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            play()
    } else {
        player.replaceCurrentItem(with: playTrack[0].trackName)
        titleOfSong.text = playTrack[0].artist + " - " + playTrack[0].name
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        play()
    }
    }
    // предыдущий трек
    func backward() {
        guard let item = player.currentItem else {
            print("tracklist is empty")
            return
        }
        var index: Int = 0
        for (trackIndex, trackName) in playTrack.enumerated() {
            if trackName.trackName == item {
                index = trackIndex
            }
        }
        if index < 1 {
            player.replaceCurrentItem(with: playTrack[0].trackName)
            titleOfSong.text = playTrack[0].artist + " - " + playTrack[0].name
            player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            play()
    } else {
        player.replaceCurrentItem(with: playTrack[index - 1].trackName)
        titleOfSong.text = playTrack[index - 1].artist + " - " + playTrack[index - 1].name
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        play()
    }
    }
    // добавление трека в список
    func addTrackToTracklist(trackNameInBundle: String, artistName: String, trackName: String) {
        let trackNameItem = AVPlayerItem(url: Bundle.main.url(forResource: trackNameInBundle, withExtension: "mp3")!)
        playTrack.append(track(name: trackName, artist: artistName, trackName: trackNameItem))
    }
    
    @objc func playerDidFinishPlaying() {
        // если нажата кнопка повторить песню, флаг становится true и текущая песня проигрывается, иначе будет играть следующая песня
        if isRepeat == true {
            player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
            play()
        } else {
            forward()
        }
    }
    
    @objc private func goToVideo() {

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        coordinator?.toVideoPlayer()


    }
    
    private func setupPlayer() {
        addTrackToTracklist(trackNameInBundle: "1", artistName: "Mareux", trackName: "babydoll x the perfect girl")
        addTrackToTracklist(trackNameInBundle: "2", artistName: "Darci", trackName: "wild hourse")
        addTrackToTracklist(trackNameInBundle: "3", artistName: "Øneheart", trackName: "snowfall")
        addTrackToTracklist(trackNameInBundle: "4", artistName: "Rosa Linn", trackName: "snap")
        addTrackToTracklist(trackNameInBundle: "5", artistName: "The neighbourhood", trackName: "sweather weather")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Video".localized, style: .plain, target: self, action: #selector(goToVideo))
        navigationItem.title = "Music List".localized
        view.backgroundColor = UIColor(named: "Pink")
        
        view.addSubview(audioView)
        view.addSubview(stackView)
        view.addSubview(titleOfSong)
        view.addSubview(repeatButton)
        
        NSLayoutConstraint.activate([
            audioView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            audioView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            audioView.heightAnchor.constraint(equalToConstant: 400),
            audioView.widthAnchor.constraint(equalToConstant: 400),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: audioView.bottomAnchor, constant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 230),
            
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            
            repeatButton.heightAnchor.constraint(equalToConstant: 50),
            repeatButton.widthAnchor.constraint(equalToConstant: 50),
            repeatButton.topAnchor.constraint(equalTo: audioView.bottomAnchor, constant: 100),
            repeatButton.leadingAnchor.constraint(equalTo: forwardButton.trailingAnchor, constant: 10),
            
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 50),
            
            forwardButton.heightAnchor.constraint(equalToConstant: 50),
            forwardButton.widthAnchor.constraint(equalToConstant: 50),
            
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            titleOfSong.topAnchor.constraint(equalTo: audioView.bottomAnchor, constant: 40),
            titleOfSong.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            titleOfSong.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPlayer()
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

