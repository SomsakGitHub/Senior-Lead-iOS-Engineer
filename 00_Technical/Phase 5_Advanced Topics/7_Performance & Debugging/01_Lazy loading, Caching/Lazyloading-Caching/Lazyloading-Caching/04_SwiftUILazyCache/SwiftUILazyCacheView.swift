//
//  SwiftUILazyCacheView.swift
//  Lazyloading-Caching
//
//  Created by somsak02061 on 4/11/2568 BE.
//

import SwiftUI

struct SwiftUILazyCacheView: View {
    @State private var photos: [Photo] = []

    var body: some View {
        List(photos) { photo in
            HStack {
                AsyncImageCacheView(url: URL(string: photo.thumbnailUrl)!)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text(photo.title)
            }
        }
        .task { await fetchPhotos() }
    }

    func fetchPhotos() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_limit=20") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            print("❌ Error:", error)
        }
    }
}

struct Photo: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnailUrl: String
}


#Preview {
    SwiftUILazyCacheView()
}
