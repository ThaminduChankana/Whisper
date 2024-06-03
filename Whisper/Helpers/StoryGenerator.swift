//
//  StoryGenerator.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import Foundation

class StoryGenerator {
    private let gptService = GPTService()
    
    func generateStory(for userInput: UserInput, completion: @escaping (String?) -> Void) {
        let prompt = constructPrompt(from: userInput)
        gptService.generateStory(prompt: prompt) { story in
            completion(story)
        }
    }
    
    private func constructPrompt(from userInput: UserInput) -> String {
        let timeline: String
        
        switch userInput.timeline.rawValue {
        case "Kingdoms":
            timeline = "a magical world filled with brave kings, wise queens, and mystical creatures"
        case "1800's":
            timeline = "times when people traveled by horse and carriage and explored new lands"
        case "1900's":
            timeline = "times of big changes, with inventions like cars, airplanes, and telephones"
        case "Present":
            timeline = "the present, where we use computers, talk on phones, and explore the world together"
        case "Future":
            timeline = "a time that's coming soon, full of possibilities and amazing discoveries"
        case "Far Future":
            timeline = "a distant future where we might explore space and meet new friends among the stars"
        default:
            timeline = ""
        }
        
        return """
            Imagine a wonderful story for \(userInput.childName), a \(userInput.age)-year-old \(userInput.gender.rawValue.lowercased())! Set the tale in the \(userInput.timeline.rawValue) timeline, where \(timeline). The story fits into the \(userInput.storyCategory.rawValue) category, with all the excitement and adventure \(userInput.storyCategory.rawValue.lowercased()) can bring. \(userInput.childName) is feeling \(userInput.mood.rawValue.lowercased()) today, so make sure the story fills their heart with joy! Ready to create a magical adventure for \(userInput.childName)? Let your imagination soar! Please keep in mind to provide the complete story from start to end and structure should be as below for every response.
            
            Title: [Generated Story Title]

            Once upon a time...

            [Generated Story Content]

            The End
            """
    }
}
