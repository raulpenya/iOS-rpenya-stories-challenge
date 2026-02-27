//
//  RooView.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 27/2/26.
//

import SwiftUI

struct RootView: View {
    @State private var storyListView: StoryListView?
    @State private var error: Error?
    
    var body: some View {
        Group {
            if let storyListView {
                storyListView
            } else if error != nil {
                Text("Error: \(error?.localizedDescription ?? "unknown")")
            } else {
                ProgressView()
            }
        }
        .task {
            await bootstrap()
        }
    }
        
    private func bootstrap() async {
        do {
            let coordinator = RootCoordinator()
            storyListView = StoryListView(viewModel: try coordinator.makeStoryListViewModel())
        } catch {
            self.error = error
        }
    }
}
