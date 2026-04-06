//🔍 พื้นฐานของ Background Modes
//
//โดยปกติ iOS จะ “หยุด” การทำงานของแอปทันทีเมื่อผู้ใช้กด Home หรือสลับไปแอปอื่น
//เพื่อประหยัดแบตและหน่วยความจำ
//แต่บางแอป (เช่น เพลง, แผนที่, โทรศัพท์, โหลดไฟล์, แจ้งเตือน)
//จำเป็นต้องทำงาน ต่อเนื่องในพื้นหลัง (Background)
//ซึ่ง Apple อนุญาตให้ทำได้ผ่านสิ่งที่เรียกว่า Background Modes

//⚙️ การเปิด Background Modes ใน Xcode
//
//เปิดโปรเจกต์ → เลือก Target → Signing & Capabilities
//กด + Capability
//เลือก Background Modes
//เปิดสวิตช์ตามฟีเจอร์ที่ต้องการ เช่น
//Background fetch
//Background processing
//Audio, AirPlay, and Picture in Picture
//Location updates
//Remote notifications
//Background URLSession

//ใช้สำหรับ “อัปโหลดหรือดาวน์โหลดไฟล์ขนาดใหญ่”
//แม้ผู้ใช้จะปิดแอป, ระบบจะยังทำงานต่อในพื้นหลัง

//✅ ตัวอย่างการดาวน์โหลดไฟล์

//class DownloadManager: NSObject, URLSessionDownloadDelegate {
//    static let shared = DownloadManager()
//
//    private lazy var session: URLSession = {
//        let config = URLSessionConfiguration.background(withIdentifier: "com.myapp.download")
//        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
//    }()
//
//    func startDownload() {
//        let url = URL(string: "https://example.com/largefile.zip")!
//        let task = session.downloadTask(with: url)
//        task.resume()
//    }
//
//    // ✅ delegate จะถูกเรียกเมื่อโหลดเสร็จ แม้แอปปิดอยู่
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("✅ Download complete: \(location)")
//    }
//}

//🎵 3. Background Audio
//
//เล่นเพลงหรือเสียงต่อได้ แม้ออกจากแอป
//เปิด Background Modes → “Audio, AirPlay, and Picture in Picture”

//✅ เปิดใช้งาน

//เปิด Background Modes → Location updates
//ขอ permission จากผู้ใช้:

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func playAudio() {
//        ต้องแน่ใจว่าใช้ AVPlayer หรือ AudioEngine ที่ไม่หยุดเมื่อออกจากแอป
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Audio session error:", error)
        }

    }
}

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    override init() {
//        ต้องมี Key ใน Info.plist
//        NSLocationAlwaysAndWhenInUseUsageDescription
        super.init()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("📍 Location:", locations.last!)
    }
}



