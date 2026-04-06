//🔹 Part 1: Deep Links (Custom URL Scheme)
//✅ คืออะไร?
//เป็น URL แบบกำหนดเอง เช่น
//myapp://something → เปิดแอปของคุณโดยตรง
//
//🧰 วิธีตั้งค่า
//ไปที่ Xcode → Target → Info → URL Types
//กด + แล้วใส่ค่า:
//Identifier: myapp
//URL Schemes: myapp ✅
//เสร็จแล้วลิงก์ myapp:// จะเปิดแอปของคุณได้
//
//📬 Handle ลิงก์ใน AppDelegate

//🔹 Part 2: Universal Links (HTTPS-based)
//✅ คืออะไร?
//
//เป็น ลิงก์ HTTPS จริง เช่น
//https://myapp.com/profile/123
//ที่เมื่อเปิดบน iPhone จะเปิดใน “แอป” ถ้ามีติดตั้ง
//และถ้าไม่มี → จะเปิดเว็บแทน (เหมือน fallback อัตโนมัติ)

//🧰 ขั้นตอนละเอียด
//🔸 Step 1: เปิด Capability

//ไปที่ Target → Signing & Capabilities → + Capability
//เลือก “Associated Domains”
//เพิ่มบรรทัด:

//applinks:myapp.com

//🔸 Step 2: สร้างไฟล์ apple-app-site-association

//ชื่อไฟล์ต้อง ไม่มีนามสกุล และอยู่ที่ root ของโดเมน เช่น
//https://myapp.com/apple-app-site-association

//{
//  "applinks": {
//    "details": [
//      {
//        "appIDs": ["ABCDE12345.com.mycompany.myapp"],
//        "paths": [ "/profile/*", "/news/*" ]
//      }
//    ]
//  }
//}

//appIDs = Team ID + Bundle Identifier
//paths = ระบุ path ที่อยากให้เปิดในแอป

//🔸 Step 3: อัปโหลดไฟล์ไปยัง Server
//
//เช่นที่
//https://myapp.com/apple-app-site-association
//ต้องใช้ HTTPS ✅
//ห้ามมี .json ต่อท้าย
//Header ต้องเป็น Content-Type: application/json

//🔸 Step 4: Handle Universal Links
//
//ใน SceneDelegate.swift

//🧠 ตัวอย่างโค้ด Combine ทั้งคู่

// Deep Link: myapp://profile/123
//func application(_ app: UIApplication,
//                 open url: URL,
//                 options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//    handleLink(url)
//    return true
//}
//
//// Universal Link: https://myapp.com/profile/123
//func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
//    if let url = userActivity.webpageURL {
//        handleLink(url)
//    }
//}
//
//// ฟังก์ชันกลาง
//func handleLink(_ url: URL) {
//    if url.path.contains("/profile/") {
//        let id = url.lastPathComponent
//        print("🧭 Navigate to profile:", id)
//        // เปิดหน้าโปรไฟล์ในแอป
//    }
//}


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

