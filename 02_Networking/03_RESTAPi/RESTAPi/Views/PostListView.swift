//
//  PostListView.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var showCreatePost = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    ProgressView("Loading posts...")
                } else if let error = viewModel.errorMessage, viewModel.posts.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchPosts()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(viewModel.posts) { post in
                            NavigationLink(value: post) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(post.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    Text(post.body)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                    HStack {
                                        Label("User \(post.userId)", systemImage: "person")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Label("ID: \(post.id)", systemImage: "number")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .onDelete { offsets in
                            Task {
                                await viewModel.deletePosts(at: offsets)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchPosts()
                    }
                }
            }
            .navigationTitle("Posts")
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post, viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCreatePost = true
                    } label: {
                        Label("Add Post", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreatePost) {
                CreatePostView(viewModel: viewModel)
            }
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
}

#Preview {
    PostListView()
}
