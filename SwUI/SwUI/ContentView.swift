//
//  ContentView.swift
//  SwUI
//
//  Created by Эля Корельская on 02.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            FeedView()
            .tabItem {
                Label("Feed", systemImage: "target")
            }
            ProfileView()
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            MusicView()
            .tabItem {
                Label("Music", systemImage: "music.note")
            }
            VideoView()
            .tabItem {
                Label("Video", systemImage: "video.square.fill")
            }
            RecorderView()
            .tabItem {
                Label("Recorder", systemImage: "waveform")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

