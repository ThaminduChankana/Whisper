//
//  GenerateStoryView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI
import CoreData

struct GenerateStoryView: View {
    @State private var childName: String = ""
    @State private var age: Int = 0
    @State private var selectedGender: Gender = .boy
    @State private var selectedStoryCategory: StoryCategory = .fairyTales
    @State private var selectedTimeline: Timeline = .kingdom
    @State private var selectedMood: Mood = .happy
    @State private var generatedStory: String = ""
    @State private var isGenerating: Bool = false
    @State private var shouldNavigate: Bool = false
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    let storyGenerator = StoryGenerator()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(header: Text("Child's Details")) {
                        TextField("Child's Name", text: $childName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        Picker("Age", selection: $age) {
                            ForEach(0..<11) { age in
                                Text("\(age) years")
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Gender", selection: $selectedGender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue.capitalized)
                            }
                        }
                    }
                    
                    Section(header: Text("Story Preferences")) {
                        Picker("Story Category", selection: $selectedStoryCategory) {
                            ForEach(StoryCategory.allCases, id: \.self) { category in
                                Text(category.rawValue.capitalized)
                            }
                        }
                        Picker("Timeline", selection: $selectedTimeline) {
                            ForEach(Timeline.allCases, id: \.self) { timeline in
                                Text(timeline.rawValue)
                            }
                        }
                        Picker("Mood", selection: $selectedMood) {
                            ForEach(Mood.allCases, id: \.self) { mood in
                                Text(mood.rawValue.capitalized)
                            }
                        }
                    }
                    
                    Section {
                        Button(action: generateStory) {
                            Text("Generate Story")
                        }
                        .disabled(isGenerating)
                    }
                }
                .disabled(isGenerating)
                
                if isGenerating {
                    VStack {
                        LottieView(filename: "book", loopMode:.loop)
                            .frame(width: 200, height: 200)
                        Text("Generating Story...")
                            .font(.headline)
                            .padding()
                        Text("Please wait while we create a magical story for you!")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationTitle("Generate Story")
            .navigationDestination(isPresented: $shouldNavigate) {
                StoryView(story: generatedStory)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Validation Failed!").bold(), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func generateStory() {
        if validateInput() {
            isGenerating = true
            let userInput = UserInput(
                childName: childName,
                age: Int(age),
                gender: selectedGender,
                storyCategory: selectedStoryCategory,
                timeline: selectedTimeline,
                mood: selectedMood
            )
            
            storyGenerator.generateStory(for: userInput) { story in
                DispatchQueue.main.async {
                    if let story = story {
                        self.generatedStory = story
                        self.saveStory(title: self.extractTitle(from: story) ?? "Untitled", content: story)
                    } else {
                        self.generatedStory = "Failed to generate story."
                    }
                    self.isGenerating = false
                    self.shouldNavigate = true
                }
            }
        }
    }
    
    func validateInput() -> Bool {
        if childName.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter the child's name."
            showingAlert = true
            return false
        }
        
        return true
    }
    
    func saveStory(title: String, content: String) {
        let newStory = Story(context: viewContext)
        newStory.title = title
        newStory.content = content
        newStory.createdAt = Date()
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save story: \(error)")
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
}

#Preview {
    GenerateStoryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
