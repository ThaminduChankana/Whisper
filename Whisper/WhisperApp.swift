//
//  WhisperApp.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//

import SwiftUI

@main
struct WhisperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
