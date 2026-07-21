//🔎 Keychain คืออะไร
//
//Keychain เป็น “Secure Storage” ที่ Apple ออกแบบมา
//สำหรับเก็บข้อมูล ส่วนตัวและสำคัญ ในระบบ iOS / macOS
//
//ข้อมูลใน Keychain ถูกเข้ารหัส (encrypted) โดยระบบ
//
//จะอยู่ในเครื่องแม้ผู้ใช้ปิดแอป หรือรีสตาร์ทเครื่อง
//
//ปลอดภัยกว่าการเก็บใน UserDefaults

//🧩 พื้นฐานการใช้งาน (UIKit / Swift)
//Keychain ไม่มี API แบบง่ายเหมือน UserDefaults
//แต่เราสามารถเขียน wrapper หรือใช้ library เช่น KeychainWrapper ได้

//✅ ตัวอย่างที่ 1: ใช้ KeychainWrapper (ง่ายสุด)
//ติดตั้งผ่าน Swift Package Manager:
//https://github.com/jrendel/SwiftKeychainWrapper

import UIKit
import SwiftKeychainWrapper
import Security
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginViewTapped(_ sender: Any) {
        let swiftUIView = LoginView()
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {

        // 3. ห่อด้วย UIHostingController
        let hostingController = UIHostingController(rootView: rootView)
        
        // 4. Present แบบ modal
        present(hostingController, animated: true, completion: nil)
    }

//    ใช้ง่ายเหมือน UserDefaults แต่ข้อมูลถูกเข้ารหัสโดยระบบ iOS
    func example1() {
        // ✅ บันทึกข้อมูล
        KeychainWrapper.standard.set("mySecretToken123", forKey: "authToken")

        // ✅ อ่านข้อมูล
        let token = KeychainWrapper.standard.string(forKey: "authToken")
        print("🔑 Token:", token ?? "ไม่มีข้อมูล")

        // ✅ ลบข้อมูล
        KeychainWrapper.standard.removeObject(forKey: "authToken")
    }
    
    func example2() {
        saveToKeychain("abc123TOKEN", key: "accessToken")

        if let token = readFromKeychain(key: "accessToken") {
            print("🔐 Access Token:", token)
        }

        deleteFromKeychain(key: "accessToken")
    }
    
    func saveToKeychain(_ value: String, key: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    func readFromKeychain(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let data = item as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
    func deleteFromKeychain(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}

