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
    
    var body: some View {
        List {
            ForEach(stories) { story in
                NavigationLink(destination: StoryView(story: story.content ?? "")) {
                    VStack(alignment: .leading) {
                        Text(story.title ?? "Untitled")
                            .font(.headline)
                        Text(story.createdAt ?? Date(), style: .date)
                            .font(.subheadline)
                    }
                    .padding(.vertical, 5) // Adds space between each story
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
