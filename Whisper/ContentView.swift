//
//  ContentView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
               OnboardingView()
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
