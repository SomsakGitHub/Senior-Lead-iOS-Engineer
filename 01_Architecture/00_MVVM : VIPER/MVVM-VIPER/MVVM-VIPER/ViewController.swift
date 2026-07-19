import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func swiftUiMVVMTapped(_ sender: Any) {
        let swiftUIView = swiftUiMVVMView()
        let hosting = UIHostingController(rootView: swiftUIView)
        self.present(hosting, animated: true)
    }
    
    @IBAction func ViperTapped(_ sender: Any) {
        let swiftUiViperView = SwiftUiViperView()
        let hosting = UIHostingController(rootView: swiftUiViperView)
        self.present(hosting, animated: true)
    }
}
