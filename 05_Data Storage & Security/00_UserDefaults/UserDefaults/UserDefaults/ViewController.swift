struct User: Codable {
    let name: String
    let age: Int
}

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func SwiftUITapped(_ sender: Any) {
        let swiftUIView = ContentView()
        pushViewController(rootView: swiftUIView)
    }
    
    @IBAction func CombineMVVMTapped(_ sender: Any) {
        let swiftUIView = Combine_MVVM()
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {

        // 3. ห่อด้วย UIHostingController
        let hostingController = UIHostingController(rootView: rootView)
        
        // 4. Present แบบ modal
        present(hostingController, animated: true, completion: nil)
    }

    func UserDefaultsDetail() {
        //🧠 UserDefaults คืออะไร
        //
        //เป็นระบบเก็บข้อมูล ขนาดเล็ก (key-value) ในเครื่องผู้ใช้
        //คล้ายกับ SharedPreferences ของ Android หรือ LocalStorage ในเว็บ
        //
        //ข้อมูลจะถูกเก็บไว้ในไฟล์ .plist ของแอปนั้น ๆ
        //และยังอยู่ต่อแม้ผู้ใช้จะปิดหรือรีสตาร์ทแอป
        
        //⚙️ ใช้งานพื้นฐาน
        //✅ 1. เก็บค่า
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.set("John", forKey: "username")
        UserDefaults.standard.set(25, forKey: "age")

        //✅ 2. ดึงค่า
        //💡 ถ้า key ไม่มีอยู่ จะได้ “ค่า default” (false, 0, หรือ nil)
        let loggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let username = UserDefaults.standard.string(forKey: "username")
        let age = UserDefaults.standard.integer(forKey: "age")

//        ✅ 3. ลบค่า
        UserDefaults.standard.removeObject(forKey: "username")
        
//        ✅ 4. ล้างทั้งหมด
//        ⚠️ ใช้ระวังนะครับ — จะล้างค่าทั้งหมดที่เคยเก็บไว้
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }

//        🧱 เก็บ Struct หรือ Object ด้วย Codable
//        UserDefaults เก็บแค่ primitive type
//        แต่เราสามารถเก็บ struct ได้ด้วยการ encode → Data ก่อน
        let user = User(name: "Alice", age: 22)
        
//        ✅ เก็บ:
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "savedUser")
        }
        
//        ✅ ดึง:
//        💡 ใช้ JSONEncoder / JSONDecoder ช่วยแปลง struct เป็น Data ได้ง่ายมาก
        if let data = UserDefaults.standard.data(forKey: "savedUser"),
           let savedUser = try? JSONDecoder().decode(User.self, from: data) {
            print("ชื่อ:", savedUser.name)
        }
    }
}

