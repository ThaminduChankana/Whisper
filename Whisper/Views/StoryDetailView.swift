//
//  StoryDetailView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-08.
//

import SwiftUI

struct StoryDetailView: View {
    var story: FirebaseStory
    @StateObject private var musicManager = MusicManager()

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    Text(story.title)
                        .bold()
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    Image("story-image")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200, height: 200)
                                            .clipShape(Circle())
                                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                                            .padding(.bottom, 10)
                    Text(story.content)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
            .navigationTitle("Story Details")
            .onAppear {
                musicManager.playRandomMusic()
            }
            .onDisappear {
                musicManager.stopMusic()
            }
            
            // Toolbar with buttons
            HStack {
                Spacer()
                Button(action: {
                    if musicManager.isPlaying {
                        musicManager.stopMusic()
                    } else {
                        musicManager.playRandomMusic()
                    }
                }) {
                    Image(systemName: musicManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    musicManager.toggleMute()
                }) {
                    Image(systemName: musicManager.isMuted ? "speaker.slash.fill" : "speaker.2.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.vertical, 10)
        }
    }
}


