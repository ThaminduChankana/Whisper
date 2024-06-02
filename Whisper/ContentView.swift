//
//  ContentView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to Whisper!")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: DashboardView()) {
                    Text("Take a Tour")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
