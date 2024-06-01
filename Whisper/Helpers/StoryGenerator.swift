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
        var timeline = ""
        
        if(userInput.timeline.rawValue == "Kingdoms"){
            timeline = "Times having a magical world filled with brave kings, wise queens, and mystical creatures"
        } else if(userInput.timeline.rawValue == "1800's"){
            timeline = "Times when people traveled by horse and carriage and explored new lands."
        } else if(userInput.timeline.rawValue == "1900's"){
            timeline = "Times of big changes, with inventions like cars, airplanes, and telephones"
        } else if(userInput.timeline.rawValue == "Present"){
            timeline = "Present, where we use computers, talk on phones, and explore the world together"
        } else if(userInput.timeline.rawValue == "Future"){
            timeline = "A time that's coming soon, full of possibilities and amazing discoveries"
        } else if(userInput.timeline.rawValue == "Far Future"){
            timeline = "a distant future where we might explore space and meet new friends among the stars"
        }
        
        return """
            Imagine a wonderful story for \(userInput.childName), a \(userInput.age)-year-old \(userInput.gender.rawValue.lowercased())! Set the tale in the \(userInput.timeline.rawValue) timeline, where \(timeline.lowercased()). the story fit into the \(userInput.storyCategory.rawValue) category, with all the excitement and adventure \(userInput.storyCategory.rawValue.lowercased()) can bring.\(userInput.childName) is feeling \(userInput.mood.rawValue.lowercased()) today, so make sure the story fills their heart with joy! Ready to create a magical adventure for \(userInput.childName)? Let your imagination soar! Give the response with the story title
            """
    }
}
