//
//  YourStoriesView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//
import SwiftUI
import CoreData

struct YourStoriesView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Story.createdAt, ascending: false)],
        animation: .default)
    private var stories: FetchedResults<Story>
    
    @Environment(\.managedObjectContext) private var viewContext

    private let images = ["story1", "story2", "story3", "story4", "story5"]
    
    var body: some View {
        List {
            ForEach(stories) { story in
                NavigationLink(destination: StoryView(story: story.content ?? "")) {
                    HStack {
                        Image(images.randomElement() ?? "image1")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .padding(.trailing, 10)

                        VStack(alignment: .leading) {
                            Text(story.title ?? "Untitled")
                                .font(.headline)
                            Text(story.createdAt ?? Date(), style: .date)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 5) // Adds space between each story
                    }
                }
                .listRowSeparator(.automatic).padding(5)
            }
            .onDelete(perform: deleteStories)
        }.padding(.top, 10)
        .listStyle(PlainListStyle())
        .navigationTitle("Your Stories")
        .toolbar {
            EditButton()
        }
    }
    
    private func deleteStories(offsets: IndexSet) {
        withAnimation {
            offsets.map { stories[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Handle the Core Data error.
                print("Failed to delete story: \(error)")
            }
        }
    }
}

#Preview {
    YourStoriesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

