//
//  PostsListView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 5/6/25.
//


// PostsListView.swift
import SwiftUI

struct PostsListView: View {
    @State private var posts: [Post] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading…")
                } else if let err = errorMessage {
                    Text("Error: \(err)")
                        .foregroundColor(.red)
                } else {
                    List(posts) { post in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(post.title).font(.headline)
                            Text(post.body).font(.subheadline).foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                await loadPosts()
            }
        }
    }

    private func loadPosts() async {
        isLoading = true
        do {
            let fetched = try await NetworkService.shared.fetchPosts()
            posts = fetched
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView()
    }
}
