//🔍 ภาพรวม: Push Notification คืออะไร?
//
//Push Notification คือการส่ง “ข้อความแจ้งเตือนจาก Server มายังอุปกรณ์ iPhone / iPad”
//เช่น “มีข้อความใหม่”, “ยอดขายเพิ่มขึ้น”, “รายการโปรดลดราคา!”
//iOS จะใช้ระบบของ Apple ที่ชื่อว่า APNs (Apple Push Notification Service) เป็นตัวกลาง

//Server → APNs → iPhone

//ถ้าใช้ Firebase → Firebase จะทำหน้าที่เป็นตัวกลางเชื่อมกับ APNs ให้อีกที

//Server → Firebase Cloud Messaging (FCM) → APNs → iPhone

//🧱 โครงสร้างหลัก
//
//Client (iOS App) – ลงทะเบียนรับ token จาก APNs
//APNs (Apple Server) – ส่งต่อ notification
//Server / Firebase – เป็น backend ที่ยิง notification ไปยัง APNs

//⚙️ ตัวอย่างการตั้งค่าใน Xcode
//
//ไปที่ Target → Signing & Capabilities
//กด + Capability
//เพิ่ม “Push Notifications” ✅

//📜 ขออนุญาตผู้ใช้ (Request Notification Permission)
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("✅ อนุญาตให้แจ้งเตือนแล้ว")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("❌ ผู้ใช้ปฏิเสธ:", error ?? "")
            }
        }
    }
}

//ควรเรียกใน AppDelegate หรือ SceneDelegate ตอนแอปเริ่ม

//📬 รับ Token จาก APNs
//ใน AppDelegate.swift

//🔥 ใช้ Firebase Cloud Messaging (FCM)
//1. ติดตั้ง Firebase SDK
//ใช้ Swift Package Manager หรือ CocoaPods

//pod 'Firebase/Messaging'

//🧪 ทดสอบส่ง Notification (ผ่าน Firebase Console)
//
//ไปที่ Firebase Console → Cloud Messaging
//กด “Send your first message”
//ใส่ Title / Body
//เลือก “iOS App”
//
//ส่งแจ้งเตือน
//ถ้าแอปอยู่ foreground จะโชว์ผ่าน delegate ด้านบน
//ถ้าแอปอยู่ background หรือปิด → ระบบจะแสดง Banner / Alert

//📦 Payload ตัวอย่างจาก Server (JSON)

//{
//  "to": "<fcm_token>",
//  "notification": {
//    "title": "ข่าวด่วน!",
//    "body": "ราคาหุ้นของคุณเพิ่มขึ้น 10%",
//    "sound": "default"
//  },
//  "data": {
//    "type": "stock_update",
//    "symbol": "AAPL"
//  }
//}

//ส่งผ่าน API ของ Firebase:

//POST https://fcm.googleapis.com/fcm/send
//Header: Authorization: key=<YOUR_SERVER_KEY>

//🧱 หากไม่ใช้ Firebase (APNs ตรง)
//สามารถใช้ APNs token และยิงตรงผ่าน HTTP/2 API
//POST https://api.push.apple.com/3/device/<device_token>
//Header: authorization: bearer <jwt_token>

//ต้องสร้าง JWT (JSON Web Token) จาก .p8 key ที่ได้จาก Apple Developer
//แต่ส่วนใหญ่ปัจจุบันใช้ Firebase เพราะง่ายกว่าและ cross-platform ✅

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

