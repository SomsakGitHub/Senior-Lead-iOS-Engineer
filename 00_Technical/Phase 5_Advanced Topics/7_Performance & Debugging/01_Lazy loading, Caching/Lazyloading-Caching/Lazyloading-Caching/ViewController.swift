import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func AsyncImageCacheTapped(_ sender: Any) {
        let asyncImageCacheVC = AsyncImageCacheView(url: URL(fileURLWithPath: ""))
        let hostVC = UIHostingController(rootView: asyncImageCacheVC)
        present(hostVC, animated: true)
    }
    
    @IBAction func SwiftUILazyCacheViewTapped(_ sender: Any) {
        let asyncImageCacheVC = SwiftUILazyCacheView()
        let hostVC = UIHostingController(rootView: asyncImageCacheVC)
        present(hostVC, animated: true)
    }
}

