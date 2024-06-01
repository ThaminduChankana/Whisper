//
//  ContentView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI

struct ContentView: View {
    @State private var childName: String = ""
    @State private var age: Int = 0
    @State private var selectedGender: Gender = .boy
    @State private var selectedStoryCategory: StoryCategory = .fairyTales
    @State private var selectedTimeline: Timeline = .present
    @State private var selectedMood: Mood = .happy
    @State private var generatedStory: String = ""
    @State private var isGenerating: Bool = false
    @State private var shouldNavigate: Bool = false
    
    let storyGenerator = StoryGenerator()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(header: Text("Child's Details")) {
                        TextField("Child's Name", text: $childName)
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
                    .background(Color(.systemBackground).opacity(0.9))
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationTitle("Whisper")
            .navigationDestination(isPresented: $shouldNavigate) {
                StoryView(story: generatedStory)
            }
        }
    }
    
    func generateStory() {
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
                self.generatedStory = story ?? "Failed to generate story."
                self.isGenerating = false
                self.shouldNavigate = true
            }
        }
    }
}

#Preview {
    ContentView()
}
