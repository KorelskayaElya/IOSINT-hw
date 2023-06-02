//
//  VideoView.swift
//  SUI
//
//  Created by Эля Корельская on 29.05.2023.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @State private var player = AVPlayer()
    var body: some View {
        VideoPlayer(player: AVPlayer(url:  URL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!))
            .frame(height: 400)
    }
}
    

struct VideoRaw: View {
    var videoName: String
    var body: some View {
        VStack{
            Text("\(videoName)")
            PlayerView()
        }
    }
}

struct VideoView: View {
    var body: some View {
        VStack{
            List {
                Section(header: Text("Video")) {
                    VideoRaw(videoName: "Cool video")
                    VideoRaw(videoName: "Reaally cool")
                    VideoRaw(videoName: "Nice video")
                    VideoRaw(videoName: "Good video")
                }
                
            }.listStyle(GroupedListStyle())
            
        }
    }
}
struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
