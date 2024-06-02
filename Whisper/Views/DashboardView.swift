//
//  GenerateStoryView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 30) {
                        Text("Whisper Board")
                            .font(.largeTitle)
                            .padding(.top, 15)

                        if geometry.size.width > geometry.size.height {
                            // Landscape layout
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                NavigationLink(destination: StoriesView()) {
                                    DashboardTile(title: "Stories", animationName: "reading")
                                }
                                
                                NavigationLink(destination: GenerateStoryView()) {
                                    DashboardTile(title: "Create Story", animationName: "writing")
                                }
                                
                                NavigationLink(destination: YourStoriesView()) {
                                    DashboardTile(title: "Your Stories", animationName: "list")
                                }
                                
                                NavigationLink(destination: MusicView()) {
                                    DashboardTile(title: "Listen", animationName: "listenning")
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            // Portrait layout
                            VStack(spacing: 20) {
                                NavigationLink(destination: StoriesView()) {
                                    DashboardTile(title: "Stories", animationName: "reading")
                                }
                                
                                NavigationLink(destination: GenerateStoryView()) {
                                    DashboardTile(title: "Create Story", animationName: "writing")
                                }
                                
                                NavigationLink(destination: YourStoriesView()) {
                                    DashboardTile(title: "Your Stories", animationName: "list")
                                }
                                
                                NavigationLink(destination: MusicView()) {
                                    DashboardTile(title: "Listen", animationName: "listenning")
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct DashboardTile: View {
    var title: String
    var animationName: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .padding(.leading, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            LottieView(filename: animationName, loopMode: .loop)
                .frame(width: 70, height: 70)
                .padding(.trailing, 20)
        }
        .frame(height: 100)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
