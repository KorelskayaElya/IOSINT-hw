//
//  MusicView.swift
//  SwUI
//
//  Created by Эля Корельская on 02.06.2023.
//

import SwiftUI
import AVFoundation

struct MusicView: View {
    @StateObject private var audioManager = AudioManager()
    @State private var scale: CGFloat = 1
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color.purple)
                .cornerRadius(20)
                .frame(width: 200,height: 200)
                .scaleEffect(scale)

                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 2)
                    let repeatedAnimation = baseAnimation.repeatForever(autoreverses: true)
                    return withAnimation(repeatedAnimation){
                        self.scale = 0.7
                    }
                
                }
            NoteView()
            HStack{
                Button(action: {
                    audioManager.playMusic()
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .foregroundColor(Color.purple)
                }
                .padding(10)
                Button(action: {
                    audioManager.stopMusic()
                }) {
                    Image(systemName: "pause.fill")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .foregroundColor(Color.purple)
                }
            }
            Text("Mareux - babydoll x the perfect girl")
                .foregroundColor(Color.purple)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
        }
        
    }
}
struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}
struct NoteView: View {
    
    var body: some View {
        Image(systemName: "music.note")
            .resizable()
            .frame(width: 50,height: 60)
            .padding(.top,-140)
            .foregroundColor(Color.black)
    }
}



class AudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?

    func playMusic() {
        guard let url = Bundle.main.url(forResource: "1", withExtension: "mp3") else {
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play music: \(error.localizedDescription)")
        }
    }

    func stopMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

