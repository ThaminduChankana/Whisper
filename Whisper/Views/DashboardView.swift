import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome message
                    Text("Welcome to Whisper")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.horizontal)

                    // Welcome Card
                    WelcomeCard()
                        .padding(.horizontal)

                    // Categories
                    Text("Select Category")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .bold()

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        NavigationLink(destination: StoriesView()) {
                            DashboardTile(title: "Quick Stories", animationName: "reading", backgroundColor: .blue)
                        }

                        NavigationLink(destination: GenerateStoryView()) {
                            DashboardTile(title: "New Stories", animationName: "writing", backgroundColor: .green)
                        }

                        NavigationLink(destination: YourStoriesView()) {
                            DashboardTile(title: "Past Stories", animationName: "list", backgroundColor: .orange)
                        }

                        NavigationLink(destination: MusicView()) {
                            DashboardTile(title: "Music", animationName: "listenning", backgroundColor: .purple)
                        }
                    }
                    .padding(.horizontal)

                    Text("Portal to a Magical World")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .bold()

                    // Magical World Section
                    NavigationLink(destination: MagicalWorldView()) {
                        MagicalWorldCard()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                .padding(.top)
            }
        }
        .onAppear {
            print("DashboardView appeared") // Debug statement
        }
    }
}

struct WelcomeCard: View {
    var body: some View {
        ZStack {
            Image("home-image") // Ensure you have an image named "home-image" in your assets
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        }
    }
}

struct DashboardTile: View {
    var title: String
    var animationName: String
    var backgroundColor: Color

    var body: some View {
        HStack {
            LottieView(filename: animationName, loopMode: .loop)
                .frame(width: 60, height: 60)
                .padding(.leading, 20)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding([.leading, .vertical])
            
            Spacer()
        }
        .frame(height: 100)
        .background(backgroundColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct MagicalWorldCard: View {
    var body: some View {
        ZStack {
            Image("magic-world")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            
            Text("Magical World")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
