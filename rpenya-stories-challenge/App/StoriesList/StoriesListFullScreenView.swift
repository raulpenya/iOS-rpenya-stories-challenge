//
//  StoryView.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import SwiftUI

struct StoriesListFullScreenView: View {

    let viewModel: StoryListViewModel

    @State private var currentIndex: Int?
    @Environment(\.dismiss) private var dismiss

    init(viewModel: StoryListViewModel, initialIndex: Int) {
        self.viewModel = viewModel
        _currentIndex = State(initialValue: initialIndex)
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(Array(viewModel.stories.enumerated()), id: \.offset) { index, story in
                    StoryFullScreenCardView(story: story, liked: viewModel.isLiked(story), toggleLike: {
                        viewModel.toggleLike(for: story)
                    })
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .id(index)
                    .onAppear {
                        viewModel.markAsSeen(story)
                    }
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $currentIndex)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 150 {
                        dismiss()
                    }
                }
        )
        .ignoresSafeArea(edges: .all)
    }
}

struct StoryFullScreenCardView: View {
    let story: Story
    let liked: Bool
    let toggleLike: () -> Void
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: story.user.profile_picture_url)) { phase in
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
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            Button(liked ? "Unlike" : "Like") {
                toggleLike()
            }
            .padding(.bottom)
        }
    }
}
