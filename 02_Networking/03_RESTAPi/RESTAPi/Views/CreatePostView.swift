//
//  CreatePostView.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI

struct CreatePostView: View {
    @ObservedObject var viewModel: PostViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var postBody = ""
    @State private var userId = 1
    @State private var showError = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Post Details") {
                    TextField("Title", text: $title)
                    TextField("Body", text: $postBody, axis: .vertical)
                        .lineLimit(5...10)
                    Stepper("User ID: \(userId)", value: $userId, in: 1...10)
                }
                
                Section {
                    Button {
                        Task {
                            let success = await viewModel.createPost(
                                title: title,
                                body: postBody,
                                userId: userId
                            )
                            if success {
                                dismiss()
                            } else {
                                showError = true
                            }
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Create Post")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(title.isEmpty || postBody.isEmpty || viewModel.isLoading)
                }
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
        }
    }
}

#Preview {
    CreatePostView(viewModel: PostViewModel())
}
