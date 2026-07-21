//🧱 2. SSL Pinning คืออะไร
//SSL Pinning = “ล็อก” server certificate หรือ public key เอาไว้ในแอป
//คือแทนที่เราจะเชื่อ “CA” ทั่วโลก
//เราบอกแอปว่า “แอปนี้ยอมรับเฉพาะใบรับรองของ server ของฉันเท่านั้น” ✅

//📌 ทำไมต้องใช้ SSL Pinning?
//เพราะบางครั้ง
//แม้ใช้ HTTPS ก็ยังเสี่ยงจาก การปลอมแปลง certificate เช่น
//Hacker ปลอม certificate แล้วดักข้อมูล (Man-in-the-middle)
//ผู้ใช้เชื่อม Wi-Fi ปลอมที่แทรก proxy
//SSL Pinning จะทำให้แอป ปฏิเสธทุก certificate ที่ไม่ตรงกับของแท้

//🛡️ วิธีทำ SSL Pinning ใน iOS
//✅ แบบที่ 1: SSL Pinning ด้วย URLSession (Native)
//1️⃣ ดาวน์โหลด certificate จาก server ของคุณ (เช่น api.myserver.com)
//ใช้ browser หรือ command:
//openssl s_client -showcerts -connect api.myserver.com:443 </dev/null 2>/dev/null | openssl x509 -o

//2️⃣ เพิ่มไฟล์ myserver.cer เข้าในโปรเจกต์ (Add to bundle)

//3️⃣ เขียน delegate ตรวจสอบ certificate

import Foundation

class SecureSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust,
              let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        // โหลด certificate จาก app bundle
        let localCertPath = Bundle.main.path(forResource: "myserver", ofType: "cer")!
        let localCertData = try! Data(contentsOf: URL(fileURLWithPath: localCertPath))
        let serverCertData = SecCertificateCopyData(certificate) as Data
        
        // ✅ เปรียบเทียบ certificate จาก server กับของใน bundle
        if localCertData == serverCertData {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            print("❌ SSL Pinning failed")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}

//4️⃣ ใช้งาน

func fetchData() {
    let delegate = SecureSessionDelegate()
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)

    let url = URL(string: "https://api.myserver.com/data")!
    let task = session.dataTask(with: url) { data, _, error in
        if let data = data {
            print("✅ Response:", String(data: data, encoding: .utf8) ?? "")
        } else {
            print("❌ Error:", error ?? "Unknown")
        }
    }
    task.resume()
}

//✅ แบบที่ 2: SSL Pinning ด้วย Alamofire

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    let session: Session
    
    private init() {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            "api.myserver.com": PinnedCertificatesTrustEvaluator()
        ]
        
        let manager = ServerTrustManager(evaluators: serverTrustPolicies)
        session = Session(serverTrustManager: manager)
    }
}

//ใช้เรียก API ได้เลย:

func fetchData0() {
//    Alamofire จะอ่านไฟล์ .cer จาก bundle แล้วตรวจสอบให้อัตโนมัติ 🔒
    NetworkManager.shared.session.request("https://api.myserver.com/data").response {
        response in
        print(response)
    }
}

//🧰 เคล็ดลับการใช้งานจริง
//
//เก็บไฟล์ .cer ใน bundle โดยไม่เปิดเผยใน GitHub (ใช้ .gitignore)
//ใบรับรองจะหมดอายุ → ต้องอัปเดตในแอปด้วย
//ถ้า API หลายตัว → สามารถ pin ได้หลายโดเมน
//สำหรับระบบที่เปลี่ยน certificate บ่อย → แนะนำใช้ public key pinning

//🚨 คำเตือน
//อย่าทำ SSL Pinning ถ้ายังอยู่ในขั้นพัฒนา (dev server)
//เพราะ certificate dev มักเปลี่ยนบ่อยมาก
//ให้เปิดใช้เฉพาะ production build เช่น

#if DEBUG
// normal HTTPS
#else
// SSL Pinning
#endif




