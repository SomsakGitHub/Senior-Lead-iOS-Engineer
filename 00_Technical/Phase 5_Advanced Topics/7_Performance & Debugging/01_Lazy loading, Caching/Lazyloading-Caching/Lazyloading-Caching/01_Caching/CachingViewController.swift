//💾 2. Caching คืออะไร?
//การเก็บข้อมูลที่โหลดแล้ว (API, Image, File ฯลฯ)
//เพื่อใช้ซ้ำในอนาคตโดยไม่ต้องโหลดใหม่จาก network

import UIKit

class CachingViewController: UIViewController {
    
    let imageCache = NSCache<NSString, UIImage>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //🧩 ตัวอย่าง Cache ด้วย NSCache (ภาพ)
    func loadImage(url: URL, into imageView: UIImageView) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            imageView.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
//        ✅ ครั้งต่อไปที่โหลด URL เดิม → ดึงจาก cache ทันที (ไม่ต้อง request network)
    }
}
