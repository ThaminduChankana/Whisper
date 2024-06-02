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
        .navigationTitle("Firebase Stories")
        .onAppear {
            viewModel.fetchStories()
        }
    }
}

struct StoryDetailView: View {
    var story: FirebaseStory

    var body: some View {
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
    }
}

#Preview {
    StoriesView()
}

