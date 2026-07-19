//
//  PostDetailView.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    @ObservedObject var viewModel: PostViewModel
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("User ID: \(post.userId)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(post.title)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Divider()
                
                Text(post.body)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Post Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        showEditSheet = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Label("Options", systemImage: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            UpdatePostView(post: post, viewModel: viewModel)
        }
        .alert("Delete Post", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deletePost(id: post.id)
                    dismiss()
                }
            }
        } message: {
            Text("Are you sure you want to delete this post?")
        }
    }
}

#Preview {
    NavigationStack {
        PostDetailView(
            post: Post(id: 1, userId: 1, title: "Sample Post", body: "This is a sample post body."),
            viewModel: PostViewModel()
        )
    }
}
