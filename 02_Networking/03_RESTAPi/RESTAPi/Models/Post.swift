//
//  Post.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation

struct Post: Identifiable, Codable, Hashable, Sendable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

struct CreatePostRequest: Codable, Sendable {
    let title: String
    let body: String
    let userId: Int
}

struct UpdatePostRequest: Codable, Sendable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
