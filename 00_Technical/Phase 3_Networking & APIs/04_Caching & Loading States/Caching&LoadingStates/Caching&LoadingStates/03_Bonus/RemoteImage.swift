import SwiftUI

struct RemoteImage: View {
    let url: URL
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image).resizable().scaledToFit()
            } else {
                ProgressView()
                    .task { await loadImage() }
            }
        }
    }
    
    @MainActor
    func loadImage() async {
        if let cached = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            image = cached
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.setObject(uiImage, forKey: url.absoluteString as NSString)
                image = uiImage
            }
        } catch {
            print("❌ โหลดรูปไม่ได้:", error)
        }
    }
}

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}


#Preview("RemoteImage") {
    RemoteImage(url: URL(string: "https://www.w3schools.com/images/w3schools_green.jpg")!)
}
