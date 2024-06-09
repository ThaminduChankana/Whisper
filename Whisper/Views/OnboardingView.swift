//
//  OnBoardingView.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isOnboardingCompleted = false

    var body: some View {
        GeometryReader { geometry in
            if isOnboardingCompleted {
                DashboardView()
            } else {
                ScrollView {
                    VStack {
                        TabView(selection: $currentPage) {
                            OnboardingPage(imageName: "onboarding1", title: "Create Stories", description: "Unleash your creativity by writing and illustrating your own stories.", showNextButton: true, currentPage: $currentPage, geometry: geometry, isOnboardingCompleted: $isOnboardingCompleted)
                                .tag(0)
                            OnboardingPage(imageName: "onboarding2", title: "Share Fun", description: "Share your exciting stories with friends and family.", showNextButton: true, currentPage: $currentPage, geometry: geometry, isOnboardingCompleted: $isOnboardingCompleted)
                                .tag(1)
                            OnboardingPage(imageName: "onboarding3", title: "Discover Magic", description: "Explore a world of imagination and magic with endless story possibilities.", showNextButton: false, currentPage: $currentPage, geometry: geometry, isOnboardingCompleted: $isOnboardingCompleted)
                                .tag(2)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingPage: View {
    var imageName: String
    var title: String
    var description: String
    var showNextButton: Bool
    @Binding var currentPage: Int
    var geometry: GeometryProxy
    @Binding var isOnboardingCompleted: Bool

    var body: some View {
        let isLandscape = geometry.size.width > geometry.size.height

        HStack {
            if isLandscape {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width * 0.35) // Reduced image width in landscape
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .padding()
            }

            VStack {
                if !isLandscape {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.6)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .padding()
                }

                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top)

                Text(description)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing, .bottom], isLandscape ? 40 : 20) // Added padding for landscape and portrait

                if showNextButton {
                    HStack {
                        Spacer()
                        Button(action: {
                            currentPage += 1
                        }) {
                            Text("Next")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 30)
                } else if title == "Discover Magic" {
                    HStack {
                        Spacer()
                        Button(action: {
                            isOnboardingCompleted = true
                        }) {
                            Text("Let's start")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 30)
                }
            }
            .frame(width: isLandscape ? geometry.size.width * 0.6 : geometry.size.width, height: geometry.size.height)
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
}
