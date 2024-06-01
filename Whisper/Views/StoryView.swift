//
//  StoryView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI

struct StoryView: View {
    let story: String

    var body: some View {
        return ScrollView {
            VStack(alignment: .center, spacing: 10) {
                if let title = extractTitle(from: story) {
                    Text(title)
                        .bold()
                        .italic()
                        .padding(.bottom, 10)
                }
                Text(extractStoryBody(from: story))
            }
            .padding()
        }
        .navigationTitle("Your Story !")
    }

    private func extractTitle(from story: String) -> String? {
        let titlePrefixes = ["Title:", "Title-", "title:-", "title:", "title-", "title:-"]
        for prefix in titlePrefixes {
            if let range = story.range(of: prefix, options: .caseInsensitive) {
                let remainingStory = story[range.upperBound...]
                if let endRange = remainingStory.range(of: "\n\n") {
                    var title = remainingStory[..<endRange.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                    // Clean up any remaining symbols or colons
                    title = title.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "-", with: "")
                    return String(title)
                }
            }
        }
        return nil
    }

    private func extractStoryBody(from story: String) -> String {
        // Remove the title and return the remaining story body
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
    StoryView(story: "Your Story !")
}
