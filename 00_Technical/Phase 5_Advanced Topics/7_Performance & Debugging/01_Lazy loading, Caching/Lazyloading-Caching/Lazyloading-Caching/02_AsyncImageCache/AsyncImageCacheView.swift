import SwiftUI

struct AsyncImageCacheView: View {
    let url: URL
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image).resizable().scaledToFill()
            } else {
                ProgressView()
                    .task {
                        await loadImage()
                    }
            }
        }
    }

    func loadImage() async {
        if let cached = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cached
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let img = UIImage(data: data) {
                ImageCache.shared.setObject(img, forKey: url.absoluteString as NSString)
                await MainActor.run { self.image = img }
            }
        } catch {
            print("❌ Failed to load:", error)
        }
    }
    
    //🧱 3. URLCache (ใช้ Cache ของระบบ)
    //URLSession มีระบบ cache ภายในอยู่แล้ว
    //สามารถตั้งค่าได้:
    func loadImage2() async {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = URLCache(memoryCapacity: 50 * 1024 * 1024,
                                   diskCapacity: 100 * 1024 * 1024,
                                   diskPath: "myCache")
        
        let session = URLSession(configuration: config)
//        ✅ Response ที่มี HTTP Header เช่น
//        Cache-Control: max-age=3600
//        จะถูกเก็บอัตโนมัติไว้ใน cache
    }
}

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}


#Preview {
    AsyncImageCacheView(url: URL(string: "https://picsum.photos/200")!)
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
}
