//🧠 Concept Overview
//🎯 1. Loading State
//
//คือสถานะที่บอกว่า “ตอนนี้แอปกำลังทำอะไรอยู่”
//เช่น:
//
//กำลังโหลด (isLoading = true)
//โหลดเสร็จ (isLoading = false)
//โหลดล้มเหลว (error != nil)
//
//เราจะใช้ state เหล่านี้เพื่อ “อัปเดต UI”
//เช่น แสดงวงกลมหมุน หรือข้อความ error

//📦 2. Caching
//
//คือการ “เก็บข้อมูลไว้ใช้ซ้ำ” โดยไม่ต้องโหลดใหม่ทุกครั้ง
//ช่วยลด:
//
//การเรียก API ซ้ำ
//การใช้อินเทอร์เน็ต
//เวลาโหลดหน้า

//🚀 ตัวอย่าง: Caching + Loading States (SwiftUI)
//สมมุติเรามี API:

//https://jsonplaceholder.typicode.com/posts

//✅ Step 1: สร้าง Model

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //✅ Step 2: สร้าง ViewModel จัดการ State + Cache
    @IBAction func Caching_Loading_States_Tapped(_ sender: Any) {
        let swiftUIView = Caching_Loading_States()
        pushViewController(rootView: swiftUIView)
    }
    
//    ⚡ Bonus: Image Caching (โหลดรูปแบบเร็ว)
    @IBAction func BonusImageCachingTapped(_ sender: Any) {
        let swiftUIView = RemoteImage(url: URL(string: "https://www.w3schools.com/images/w3schools_green.jpg")!)
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {

        // 3. ห่อด้วย UIHostingController
        let hostingController = UIHostingController(rootView: rootView)
        
        // 4. Present แบบ modal
        present(hostingController, animated: true, completion: nil)
    }
    
}

