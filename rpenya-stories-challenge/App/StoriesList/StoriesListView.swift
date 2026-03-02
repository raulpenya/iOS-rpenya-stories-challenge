//
//  StoryListView.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import SwiftUI

struct StorySelection: Identifiable {
    let id: Int
}

struct StoryListView: View {
    @Bindable var viewModel: StoryListViewModel
    @State private var selection: StorySelection?
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                    StoryCardView(story: story, seen: viewModel.isSeen(story))
                        .onAppear {
                            if viewModel.isLast(index) {
                                viewModel.loadNextPage()
                            }
                        }
                        .onTapGesture {
                            selection = StorySelection(id: index)
                        }
                }
            }
            .padding(.horizontal)
        }
        .task {
            viewModel.loadNextPage()
        }
        .fullScreenCover(item: $selection) { selection in
            StoriesListFullScreenView(
                viewModel: viewModel,
                initialIndex: selection.id
            )
        }
        .alert(item: $viewModel.alertError) { alertError in
            Alert(
                title: Text("Error"),
                message: Text(alertError.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct StoryCardView: View {
    let story: Story
    let seen: Bool
    
    var body: some View {
        ZStack {
            AsyncImage(url: story.user.profilePictureURL) { phase in
                switch phase {
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image
                        .resizable()
                default:
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(.rect(cornerRadius: 50))
        }
        .overlay(
            Circle()
                .stroke(seen ? Color.gray : Color.red, lineWidth: 4)
        )
    }
}
