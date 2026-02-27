//
//  StoryListView.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import SwiftUI

struct StoryListView: View {
    let viewModel: StoryListViewModel
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.stories) { story in
                    StoryCardView(story: story)
                        .onAppear {
                            if viewModel.isLast(story) {
                                viewModel.loadNextPage()
                            }
                        }
                        .onTapGesture { _ in
                            
                        }
                }
            }
            .padding(.horizontal)
        }
        .task {
            viewModel.loadNextPage()
        }
    }
}

struct StoryCardView: View {
    let story: Story
    
    var body: some View {
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
        .frame(width: 100, height: 100)
        .clipShape(.rect(cornerRadius: 50))
    }
}

//#Preview {
//    StoryListView()
//}
