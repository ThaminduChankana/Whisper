//
//  StoriesViewModel.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class StoriesViewModel: ObservableObject {
    @Published var stories: [FirebaseStory] = []

    private var db = Firestore.firestore()

    func fetchStories() {
        db.collection("stories").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }

                self.stories = documents.compactMap { document -> FirebaseStory? in
                    do {
                        let story = try document.data(as: FirebaseStory.self)
                        return story
                    } catch {
                        print("Error decoding story: \(error)")
                        return nil
                    }
                }
            }
        }
    }
}

