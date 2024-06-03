//
//  MusicView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//

import SwiftUI

struct MusicView: View {
    @StateObject private var musicManager = MusicManager()
    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var isEditing: Bool = false
    @State private var isOrientationChanging: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if geometry.size.width > geometry.size.height {
                    // Landscape view
                    LandscapeMusicView(musicManager: musicManager, currentTime: $currentTime, duration: $duration, isEditing: $isEditing)
                } else {
                    // Portrait view
                    PortraitMusicView(musicManager: musicManager, currentTime: $currentTime, duration: $duration, isEditing: $isEditing)
                }
            }
            .onAppear {
                if !musicManager.isPlaying {
                    musicManager.playRandomMusic()
                }
            }
            .onDisappear {
                if !isOrientationChanging {
                    musicManager.stopMusic()
                }
            }
            .onChange(of: geometry.size) { newSize, oldSize in
                isOrientationChanging = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isOrientationChanging = false
                }
            }
            
        }
    }
}

struct PortraitMusicView: View {
    @ObservedObject var musicManager: MusicManager
    @Binding var currentTime: Double
    @Binding var duration: Double
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack {
            Text("Music Player")
                .font(.largeTitle)
                .padding()
            
            VStack {
                // Add Lottie animation
                LottieView(filename: "music_player", loopMode: .loop)
                    .frame(height: 200)
                    .padding(.bottom, 20)
                
                Text(musicManager.currentFileName)
                    .font(.headline)
                    .padding(.top, 10)
                
                Slider(value: $currentTime, in: 0...duration, onEditingChanged: { editing in
                    isEditing = editing
                    if !editing {
                        musicManager.seek(to: currentTime)
                    }
                })
                .padding()
                
                HStack {
                    Text(timeString(time: currentTime))
                    Spacer()
                    Text(timeString(time: duration))
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Button(action: {
                        musicManager.previousTrack()
                    }) {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        musicManager.playPauseMusic()
                    }) {
                        Image(systemName: musicManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        musicManager.nextTrack()
                    }) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                
                HStack {
                    Button(action: {
                        musicManager.toggleRepeat()
                    }) {
                        Image(systemName: musicManager.isRepeating ? "repeat.circle.fill" : "repeat.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        musicManager.toggleShuffle()
                    }) {
                        Image(systemName: musicManager.isShuffling ? "shuffle.circle.fill" : "shuffle.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
            }
            .padding()
            
            Spacer()
            
            Text("To keep listening to music, don't exit the music player.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 50)
        }
        .onReceive(musicManager.$currentTime) { time in
            if !isEditing {
                currentTime = time
            }
        }
        .onReceive(musicManager.$duration) { time in
            duration = time
        }
    }
    
    private func timeString(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct LandscapeMusicView: View {
    @ObservedObject var musicManager: MusicManager
    @Binding var currentTime: Double
    @Binding var duration: Double
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            VStack {
                Text("Music Player")
                    .font(.largeTitle)
                    .padding()
                
                // Add Lottie animation
                LottieView(filename: "music_player", loopMode: .loop)
                    .frame(height: 150)
                    .padding(.bottom, 20)
                
                Text(musicManager.currentFileName)
                    .font(.headline)
                    .padding(.top, 10)
            }
            .padding()
            
            VStack {
                Slider(value: $currentTime, in: 0...duration, onEditingChanged: { editing in
                    isEditing = editing
                    if !editing {
                        musicManager.seek(to: currentTime)
                    }
                })
                .padding()
                
                HStack {
                    Text(timeString(time: currentTime))
                    Spacer()
                    Text(timeString(time: duration))
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Button(action: {
                        musicManager.previousTrack()
                    }) {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        musicManager.playPauseMusic()
                    }) {
                        Image(systemName: musicManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        musicManager.nextTrack()
                    }) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                
                HStack {
                    Button(action: {
                        musicManager.toggleRepeat()
                    }) {
                        Image(systemName: musicManager.isRepeating ? "repeat.circle.fill" : "repeat.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        musicManager.toggleShuffle()
                    }) {
                        Image(systemName: musicManager.isShuffling ? "shuffle.circle.fill" : "shuffle.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
            }
            .padding()
            
            Spacer()
        }
        .onReceive(musicManager.$currentTime) { time in
            if !isEditing {
                currentTime = time
            }
        }
        .onReceive(musicManager.$duration) { time in
            duration = time
        }
    }
    
    private func timeString(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    MusicView().environmentObject(MusicManager())
}
