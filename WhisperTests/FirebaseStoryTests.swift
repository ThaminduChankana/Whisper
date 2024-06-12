//
//  FirebaseStoryTests.swift
//  WhisperTests
//
//  Created by Thamindu Gamage on 2024-06-11.
//

import XCTest
import FirebaseFirestoreSwift
@testable import Whisper

struct TestFirebaseStory: Codable {
    var id: String?
    var title: String
    var content: String
    var createdAt: Date
}

class FirebaseStoryTests: XCTestCase {

    func testFirebaseStoryInitialization() {
        // Create a sample date
        let sampleDate = Date()

        // Initialize a TestFirebaseStory instance
        let story = TestFirebaseStory(id: "123", title: "Test Title", content: "This is a test content.", createdAt: sampleDate)

        // Verify the properties
        XCTAssertEqual(story.id, "123", "The ID should be '123'")
        XCTAssertEqual(story.title, "Test Title", "The title should be 'Test Title'")
        XCTAssertEqual(story.content, "This is a test content.", "The content should be 'This is a test content.'")
        XCTAssertEqual(story.createdAt, sampleDate, "The createdAt date should match the sample date")
    }

    func testFirebaseStoryDecoding() throws {
        // Create a sample date
        let sampleDate = Date()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let dateString = String(data: try encoder.encode(sampleDate), encoding: .utf8)!

        // Create a sample JSON string
        let jsonString = """
        {
            "id": "123",
            "title": "Test Title",
            "content": "This is a test content.",
            "createdAt": \(dateString)
        }
        """

        // Decode the JSON to TestFirebaseStory
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = jsonString.data(using: .utf8)!
        let story = try decoder.decode(TestFirebaseStory.self, from: data)

        // Verify the properties
        XCTAssertEqual(story.id, "123", "The ID should be '123'")
        XCTAssertEqual(story.title, "Test Title", "The title should be 'Test Title'")
        XCTAssertEqual(story.content, "This is a test content.", "The content should be 'This is a test content.'")
    
    }
}
