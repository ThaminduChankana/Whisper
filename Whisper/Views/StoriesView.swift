//
//  StoriesView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//

import SwiftUI

struct StoriesView: View {
    @StateObject private var viewModel = StoriesViewModel()

    var body: some View {
        List {
            ForEach(viewModel.stories) { story in
                NavigationLink(destination: StoryDetailView(story: story)) {
                    VStack(alignment: .leading) {
                        Text(story.title)
                            .font(.headline)
                        Text(story.createdAt, style: .date)
                            .font(.subheadline)
                    }
                    .padding(.vertical, 5) // Adds space between each story
                }
                .listRowSeparator(.automatic).padding(5)
            }
        }
        .padding(.top, 10)
        .listStyle(PlainListStyle())
        .navigationTitle("Quick Stories")
        .onAppear {
            viewModel.fetchStories()
        }
    }
}

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

#Preview {
    StoriesView()
}
