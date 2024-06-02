//
//  FirebaseStory.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//

import Foundation
import FirebaseFirestoreSwift

struct FirebaseStory: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var content: String
    var createdAt: Date
}
