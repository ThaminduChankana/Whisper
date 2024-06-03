//
//  GPTService.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import Foundation

class GPTService {
    private let apiUrl = "https://api.ai21.com/studio/v1/j2-ultra/chat"
    private let apiKey = "Feqz0UP90howxBOsnAxiJC3lbVkrptEn"

    func generateStory(prompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let payload: [String: Any] = [
            "numResults": 1,
            "temperature": 0.7,  // Lowered temperature for more focused output
            "maxTokens": 500,    // Adjust max tokens if needed
            "messages": [
                [
                    "text": prompt,
                    "role": "user"
                ]
            ],
            "system": "You are a realistic storyteller. Your responses need to attract children aged between 0 to 10 years and must provide a complete story ending with 'The End'."
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let outputs = responseDict["outputs"] as? [[String: Any]],
               let text = outputs.first?["text"] as? String {
                
                // List of possible endings
                let possibleEndings = ["The End", "the end", "THE END"]
                
                // Check if the story ends with any of the possible endings
                let storyEndsProperly = possibleEndings.contains { ending in
                    text.range(of: ending, options: .caseInsensitive, range: text.index(text.endIndex, offsetBy: -50)..<text.endIndex) != nil
                }
                
                if storyEndsProperly {
                    completion(text)
                } else {
                    // If the story is incomplete, append "The End"
                    let completeText = text + "\n\nThe End"
                    completion(completeText)
                }
            } else {
                completion(nil)
            }
        }

        task.resume()
    }
}

