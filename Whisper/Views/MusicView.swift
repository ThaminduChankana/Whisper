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

    var body: some View {
        VStack {
            Text("Music Player")
                .font(.largeTitle)
                .padding()

            VStack {
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
                        if musicManager.isPlaying {
                            musicManager.stopMusic()
                        } else {
                            if musicManager.isShuffling {
                                musicManager.playRandomMusic()
                            } else {
                                musicManager.playCurrentMusic()
                            }
                        }
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
        .onAppear {
            musicManager.playRandomMusic()
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
