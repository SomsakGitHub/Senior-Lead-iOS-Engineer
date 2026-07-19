//
//  PostViewModel.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedPost: Post?
    
    private let apiService: APIService
    
    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }
    
    // MARK: - Fetch All Posts
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            posts = try await apiService.fetchPosts()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Fetch Single Post
    func fetchPost(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            selectedPost = try await apiService.fetchPost(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Create Post
    func createPost(title: String, body: String, userId: Int) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        let request = CreatePostRequest(title: title, body: body, userId: userId)
        
        do {
            let newPost = try await apiService.createPost(request: request)
            posts.insert(newPost, at: 0)
            isLoading = false
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    // MARK: - Update Post
    func updatePost(id: Int, title: String, body: String, userId: Int) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        let request = UpdatePostRequest(id: id, title: title, body: body, userId: userId)
        
        do {
            let updatedPost = try await apiService.updatePost(request: request)
            if let index = posts.firstIndex(where: { $0.id == id }) {
                posts[index] = updatedPost
            }
            isLoading = false
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    // MARK: - Delete Post
    func deletePost(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await apiService.deletePost(id: id)
            posts.removeAll { $0.id == id }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Delete Posts at Offsets
    func deletePosts(at offsets: IndexSet) async {
        for index in offsets {
            let post = posts[index]
            await deletePost(id: post.id)
        }
    }
}
