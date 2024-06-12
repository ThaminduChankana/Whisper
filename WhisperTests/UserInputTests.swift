//
//  UserInputTests.swift
//  WhisperTests
//
//  Created by Thamindu Gamage on 2024-06-11.
//

import XCTest

@testable import Whisper

class UserInputTests: XCTestCase {

    func testUserInputInitialization() {
        // Given
        let childName = "Alice"
        let age = 7
        let gender: Gender = .girl
        let storyCategory: StoryCategory = .fantasy
        let timeline: Timeline = .present
        let mood: Mood = .happy
        
        // When
        let userInput = UserInput(childName: childName, age: age, gender: gender, storyCategory: storyCategory, timeline: timeline, mood: mood)
        
        // Then
        XCTAssertEqual(userInput.childName, childName, "Child name should be \(childName)")
        XCTAssertEqual(userInput.age, age, "Age should be \(age)")
        XCTAssertEqual(userInput.gender, gender, "Gender should be \(gender)")
        XCTAssertEqual(userInput.storyCategory, storyCategory, "Story category should be \(storyCategory)")
        XCTAssertEqual(userInput.timeline, timeline, "Timeline should be \(timeline)")
        XCTAssertEqual(userInput.mood, mood, "Mood should be \(mood)")
    }
}
