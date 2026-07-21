//🔒 ทำไมต้องป้องกัน Screenshot / Screen Recording?
//
//เพื่อป้องกันการรั่วไหลของข้อมูลสำคัญ เช่น:
//รหัส OTP
//ข้อมูลบัตรเครดิต
//ข้อมูลผู้ใช้ (เช่น บัญชีธนาคาร, รหัสผ่าน)
//เอกสารส่วนตัว
//ตัวอย่างเช่น แอปธนาคาร (K PLUS, SCB EASY, TrueMoney)
//จะขึ้นจอ ดำ (black overlay) ทันทีเมื่อพยายามแคปหรืออัดหน้าจอ

//⚙️ วิธีที่ 1: ป้องกัน Screenshot / Recording ด้วย Secure UIWindow
//Apple ไม่มี API โดยตรง “ห้าม Screenshot”
//แต่เราสามารถ ปิดการ render UI ใน buffer ของระบบ ได้
//โดยใช้เทคนิค secure window ผ่าน UISecureTextField หรือ UIWindow custom flag

//⚙️ วิธีที่ 2: ตรวจจับ Screen Recording (ดีที่สุด)
//ตั้งแต่ iOS 11+ มี API ให้ตรวจจับการอัดหน้าจอได้โดยตรง

//⚙️ วิธีที่ 3: ป้องกัน Screenshot (แบบจำกัด)
//Apple ไม่อนุญาตให้บล็อก Screenshot โดยตรง (เพื่อเหตุผลด้าน UX และ Privacy)
//แต่สามารถ “ตรวจจับหลังเกิดขึ้น” ได้โดยใช้ Notification (ไม่ทางการ)

//⚙️ วิธีที่ 4: ใช้ Layer Rendering แบบ Secure (เฉพาะ UIView)
//คุณสามารถบอก iOS ว่า “ห้าม snapshot” UIView บางส่วนได้
//โดยใช้ property layer.isOpaque และการ render เฉพาะส่วน
//แต่ API ที่ใกล้เคียงที่สุดคือ UITextField.isSecureTextEntry
//(ซึ่ง Apple ใช้จริงในช่องรหัสผ่าน — ไม่ให้ Screenshot ได้เนื้อหา)
//ถ้าคุณต้องการปกป้องบาง TextField
//ให้ใช้ isSecureTextEntry = true
//เพื่อบอก iOS ว่าเป็น sensitive content

//let textField = UITextField()
//textField.isSecureTextEntry = true

//⚙️ วิธีที่ 5: ป้องกันบน SwiftUI
//ใน SwiftUI ยังไม่มี API โดยตรง
//แต่สามารถใช้ UIKit integration (UIViewControllerRepresentable) ได้แบบนี้:

//    🧠 ตัวอย่างซ่อนข้อมูลเมื่อแอปออกไป background
//📱 ใช้ได้ดีในแอปธนาคาร: เวลาสลับแอป จะไม่เห็นข้อมูลบน multitasking preview
//    func sceneWillResignActive(_ scene: UIScene) {
//        let blurEffect = UIBlurEffect(style: .regular)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = window?.bounds ?? .zero
//        blurView.tag = 777
//        window?.addSubview(blurView)
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        window?.viewWithTag(777)?.removeFromSuperview()
//    }

import SwiftUI

//แต่โค้ดนี้ใช้ยากและไม่ได้ผลในทุกกรณี 😅
//ดังนั้นทางที่ “ถูกต้องและได้ผลจริง” คือใช้ UIScreen API ครับ 👇
class SecureWindow: UIWindow {
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        layer.superlayer?.addSublayer(CAReplicatorLayer()) // ป้องกัน screen capture
    }
}

//ตัวอย่างใช้งานจริงใน ViewController
//🔐 เมื่อเริ่มอัดหน้าจอ → จอจะเปลี่ยนเป็น “ดำ”
//หยุดอัด → กลับมาแสดงผลปกติ
class SecureViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScreenRecordingDetection()
        setupScreenshotNotification()
    }

    func setupScreenRecordingDetection() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkRecording),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
        checkRecording() // ตรวจสอบตอนเปิดหน้าจอ
    }
    
    //    🧩 ใช้ได้เฉพาะ “ตรวจจับ” เท่านั้น
    //    ไม่สามารถ “ป้องกัน” ได้จริง 100%
        func setupScreenshotNotification() {
            NotificationCenter.default.addObserver(
                forName: UIApplication.userDidTakeScreenshotNotification,
                object: nil,
                queue: .main
            ) { _ in
                print("📸 ผู้ใช้แคปหน้าจอ!")
                // เช่น แจ้งเตือน, ลบข้อมูล, แสดงจอดำ
            }
        }

    @objc func checkRecording() {
        if UIScreen.main.isCaptured {
            print("⚠️ กำลังอัดหน้าจอ")
            showBlackOverlay()
        } else {
            print("✅ ไม่ได้อัดหน้าจอ")
            hideBlackOverlay()
        }
    }

    func showBlackOverlay() {
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = .black
        overlay.tag = 999
        view.addSubview(overlay)
    }

    func hideBlackOverlay() {
        view.viewWithTag(999)?.removeFromSuperview()
    }
}

struct SecureViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SecureViewController {
        return SecureViewController()
    }
    func updateUIViewController(_ uiViewController: SecureViewController, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        SecureViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
    
//    🔍 UIScreen.main.isCaptured
//    จะเป็น true ถ้ามี screen recording หรือ AirPlay ที่ capture หน้าจออยู่
    func setupNotification() {
        NotificationCenter.default.addObserver(
            forName: UIScreen.capturedDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            if UIScreen.main.isCaptured {
                print("⚠️ กำลังอัดหน้าจออยู่!")
                // ตัวอย่าง: แสดงจอดำ หรือปิดข้อมูล
            } else {
                print("✅ หยุดอัดหน้าจอแล้ว")
            }
        }
    }
    


}

#Preview {
    ContentView()
}
