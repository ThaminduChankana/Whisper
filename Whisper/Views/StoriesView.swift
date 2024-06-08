import SwiftUI

struct StoriesView: View {
    @StateObject private var viewModel = StoriesViewModel()

    let images = ["story1", "story2", "story3", "story4", "story5"]

    var body: some View {
        List {
            ForEach(viewModel.stories) { story in
                let randomImage = images.randomElement() ?? "image1"
                NavigationLink(destination: StoryDetailView(story: story)) {
                    HStack {
                        Image(randomImage)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .padding(.trailing, 10)

                        VStack(alignment: .leading) {
                            Text(story.title)
                                .font(.headline)
                            Text(story.createdAt, style: .date)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 5) // Adds space between each story
                    }
                }
                .listRowSeparator(.automatic).padding(5)
            }
        }
        .padding(.top, 10)
        .listStyle(PlainListStyle())
        .navigationTitle("Quick Stories")
        .onAppear {
            viewModel.fetchStories()
        }
    }
}


#Preview {
    StoriesView()
}

