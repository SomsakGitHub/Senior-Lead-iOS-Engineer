import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    🧱 Part 1: Auto Layout (UIKit)
    //🧭 แนวคิดหลัก
    //Auto Layout ทำงานจาก Constraints
    //→ คือ “กฎ” บอกว่ามุม, ขนาด, ระยะห่าง ของ View เป็นอย่างไร
    //เช่น 👇
    //button.centerX = superview.centerX → ปุ่มอยู่ตรงกลางแนวนอน
    //label.top = button.bottom + 8 → ห่างจากปุ่ม 8 pt
    //imageView.width = 100 → ความกว้างคงที่

    //🧩 วิธีใช้ Auto Layout
    //✅ 1. Interface Builder (ลากเส้นใน Storyboard)
    //ใช้ “Constraints” และ “Stack View” ช่วยจัด layout ได้ง่าย
    //ปรับค่า “Leading / Trailing / Top / Bottom” และ “Spacing” ได้ใน Inspector

    //✅ 2. เขียนด้วยโค้ด (Programmatic Auto Layout)
//        programmaticAutoLayout()

    //🧰 Stack View (ของดีประจำ Auto Layout)
    //ช่วยจัดเรียง view แนวนอน/แนวตั้งแบบอัตโนมัติ
//        stackView()
    
//    🍏 Part 2: SwiftUI Layout
//    💡 SwiftUI ใช้ “Declarative UI” — เขียนบอกว่า อยากได้อะไร ไม่ต้องบอก ทำยังไง
//    มันจะจัด layout ให้เองโดยอิงจาก container และ modifier
    
    @IBAction func declarativeUIButtonTapped(_ sender: Any) {
        let swiftUIView = DeclarativeUI()
        pushViewController(rootView: swiftUIView)
    }
    
    @IBAction func layoutInLayoutButtonTapped(_ sender: Any) {
        let swiftUIView = LayoutInLayout()
        pushViewController(rootView: swiftUIView)
    }
    
    @IBAction func alignmentFrameButtonTapped(_ sender: Any) {
        let swiftUIView = AlignmentFrame()
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {
        let hostingController = UIHostingController(rootView: rootView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
