//
//  StoryView.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import SwiftUI

struct StoriesListFullScreenView: View {

    @Bindable var viewModel: StoryListViewModel

    @State private var currentIndex: Int?
    @Environment(\.dismiss) private var dismiss

    init(viewModel: StoryListViewModel, initialIndex: Int) {
        self.viewModel = viewModel
        _currentIndex = State(initialValue: initialIndex)
    }

    var body: some View {
        ScrollViewReader { proxy in
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
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .onAppear {
                proxy.scrollTo(currentIndex, anchor: .leading)
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height > 150 {
                            dismiss()
                        }
                    }
            )
            .ignoresSafeArea()
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

struct StoryFullScreenCardView: View {
    let story: Story
    let liked: Bool
    let toggleLike: () -> Void
    
    var body: some View {
        ZStack {
            AsyncImage(url: story.pictureURL) { phase in
                switch phase {
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    ProgressView()
                }
            }
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.3),
                    Color.clear,
                    Color.black.opacity(0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                HStack(spacing: 12) {
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
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Text(story.user.name)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)
                
                Spacer()
                
                Button(action: toggleLike) {
                    Text(liked ? "Unlike" : "Like")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Capsule())
                }
                .padding(.bottom, 60)
            }
           
        }
    }
}
