import SwiftUI
import Security
import Combine

struct User: Codable {
    let id: Int
    let name: String
}

//✅ ตัวอย่าง: บันทึก / อ่าน / ลบ Token ใน Keychain
class KeychainManager {
    
    static func save(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            // ลบของเก่าก่อน (ถ้ามี key เดิม)
            SecItemDelete(query as CFDictionary)
            // เพิ่มข้อมูลใหม่
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    static func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess,
           let data = dataTypeRef as? Data,
           let result = String(data: data, encoding: .utf8) {
            return result
        }
        return nil
    }
    
    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}

class AuthViewModel: ObservableObject {
    @Published var token: String? {
        didSet {
            if let token = token {
                KeychainManager.save(key: "authToken", value: token)
            } else {
                KeychainManager.delete(key: "authToken")
            }
        }
    }
    
    init() {
        token = KeychainManager.load(key: "authToken")
    }
}

struct ContentView: View {
    @StateObject var vm = AuthViewModel()
    
    var body: some View {
        VStack {
            if let token = vm.token {
                Text("✅ Logged in with token: \(token)")
                Button("Logout") { vm.token = nil }
            } else {
                Button("Login") { vm.token = "secretToken123" }
            }
        }
        .padding()
    }
    
//    ✅ การใช้งานจริง
    func KeychainManagerUse() {
        KeychainManager.save(key: "authToken", value: "abc123")

        if let token = KeychainManager.load(key: "authToken") {
            print("🔑 Token:", token)
        }

        KeychainManager.delete(key: "authToken")
    }
    
    func keychainStruct() {
        let user = User(id: 1, name: "Alice")

        if let data = try? JSONEncoder().encode(user) {
            KeychainManager.save(key: "currentUser", value: data.base64EncodedString())
        }
    }
    
//ดึงกลับมา:
    func keychainStructGet() {
        if let str = KeychainManager.load(key: "currentUser"),
           let data = Data(base64Encoded: str),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            print("👩‍💻 Name:", user.name)
        }
    }
}

#Preview {
    ContentView()
}

//🧠 Keychain คืออะไร
//
//Keychain คือระบบจัดเก็บข้อมูลลับ (secure storage) ที่ถูกเข้ารหัสโดย iOS/macOS
//Apple จัดเก็บข้อมูลไว้ใน “Secure Enclave” ซึ่งระบบปฏิบัติการเท่านั้นที่เข้าถึงได้

//🔒 จุดเด่น
//ข้อมูลถูกเข้ารหัส (AES-256)
//ปลอดภัยแม้ผู้ใช้รีสตาร์ทเครื่อง
//ผูกกับ biometric (Touch ID / Face ID) ได้
//Sync ผ่าน iCloud Keychain ได้

//💼 Keychain Access (App ใน macOS)
//
//ใน macOS จะมีแอปชื่อ Keychain Access.app
//อยู่ที่: /Applications/Utilities/Keychain Access.app
//ใช้สำหรับดู / แก้ไข / ลบข้อมูลที่อยู่ใน keychain เช่น
//Password ของ Wi-Fi
//Login credentials ของ Safari
//Certificates, Keys, Secure Notes

//⚙️ Keychain บน iOS App
//
//บน iOS ไม่มี UI ให้ดูแบบ Keychain Access
//แต่สามารถเข้าถึงผ่านโค้ด Swift ได้เท่านั้น
//โดยใช้ API จาก framework Security.framework

//🔹 การใช้งาน Keychain ใน Swift
//
//Apple ให้ API ระดับล่าง (C-style) ผ่าน Security framework
//แต่เราสามารถห่อให้ใช้ง่ายขึ้นใน Swift

//📦 เก็บข้อมูลแบบ struct (ด้วย Codable)
//
//ถ้าอยากเก็บ object เช่น UserModel
//ให้ encode เป็น Data ก่อน




