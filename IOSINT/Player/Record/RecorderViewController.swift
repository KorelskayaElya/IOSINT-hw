//
//  RecorderViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 16.02.2023.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    weak var coordinator: FeedCoordinator?
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.addArrangedSubview(recordBtn)
        stack.addArrangedSubview(playBtn)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var playBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(recordPlay), for: .touchUpInside)
        return button
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Bug".localized
        label.tintColor = .black
        label.font = UIFont(name: "Helvetica Neue", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var recordBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "record.circle"), for: .normal)
        button.tintColor = .black
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapRecord), for: .touchUpInside)
        return button
    }()

    func checkMicrphone() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordBtn.isEnabled = true
                    } else {
                        print("failed")
                    }
                }
            }
        } catch {
            print("failed")
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "Pink")
        view.addSubview(stackView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.widthAnchor.constraint(equalToConstant: 150),
            
            playBtn.heightAnchor.constraint(equalToConstant: 50),
            playBtn.widthAnchor.constraint(equalToConstant: 50),

            recordBtn.heightAnchor.constraint(equalToConstant: 50),
            recordBtn.widthAnchor.constraint(equalToConstant: 50),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func getRecordFile() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        checkMicrphone()
    }

    @objc private func tapRecord () {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
     func startRecording() {
         let audioFileURL = getRecordFile().appendingPathComponent("record.m4a")
         let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
            ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordBtn.tintColor = .red
        } catch {
            recordBtn.tintColor = .black
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success == true {
            recordBtn.tintColor = .black
            playBtn.isHidden = false
        } else {
            recordBtn.tintColor = .black
            recordBtn.setTitleColor(.black, for: .normal)
            playBtn.isHidden = true

        }
    }

    @objc private func recordPlay() {
        if audioPlayer == nil {
            startPlay()
        } else {
            finishPlay()
        }
    }
    
    func startPlay() {
        let audioFilename = getRecordFile().appendingPathComponent("record.m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            playBtn.isHidden = true
            
        }
    }
    
    func finishPlay() {
        audioPlayer = nil
    }
}

extension RecorderViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        finishPlay()
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

