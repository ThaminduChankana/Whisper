//
//  StoryView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//
import SwiftUI

struct StoryView: View {
    let story: String
    @StateObject private var musicManager = MusicManager()

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    if let title = extractTitle(from: story) {
                        Text(title)
                            .bold()
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    Text(extractStoryBody(from: story))
                        .multilineTextAlignment(.leading)
                }
                .padding()
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
        .navigationTitle("Your Story!")
        .onAppear {
            musicManager.playRandomMusic()
        }
        .onDisappear {
            musicManager.stopMusic()
        }
    }

    private func extractTitle(from story: String) -> String? {
        let titlePrefixes = ["Title:", "Title-", "title:-", "title:", "title-", "title:-"]
        for prefix in titlePrefixes {
            if let range = story.range(of: prefix, options: .caseInsensitive) {
                let remainingStory = story[range.upperBound...]
                if let endRange = remainingStory.range(of: "\n\n") {
                    var title = remainingStory[..<endRange.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                    title = title.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "-", with: "")
                    return String(title)
                }
            }
        }
        return nil
    }

    private func extractStoryBody(from story: String) -> String {
        let titlePrefixes = ["Title:", "Title-", "title:-", "title:", "title-", "title:-"]
        for prefix in titlePrefixes {
            if let range = story.range(of: prefix, options: .caseInsensitive) {
                let remainingStory = story[range.upperBound...]
                if let endRange = remainingStory.range(of: "\n\n") {
                    return String(remainingStory[endRange.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        }
        return story
    }
}

#Preview {
    StoryView(story: "Your Story!")
}
