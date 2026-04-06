//🧭 ภาพรวมของ Instruments
//Instruments เป็นเครื่องมือใน Xcode ที่ใช้สำหรับ
//✅ วิเคราะห์ประสิทธิภาพของแอป (Performance Profiling)
//✅ ตรวจจับ memory leak, retain cycle, การใช้ CPU/GPU, และอื่น ๆ
//
//เปิดได้จาก:
//🔹 Xcode → Product → Profile (⌘ + I)
//หรือ
//🔹 เปิดผ่านแอป Instruments แยกต่างหาก

//🧠 1. Memory Leak คืออะไร?
//💬 คำจำกัดความ:
//
//Memory Leak = หน่วยความจำที่ถูก allocate แล้ว “ไม่ถูกคืน (deallocated)” เพราะยังมีการอ้างอิงถึงมันอยู่
//
//🧨 ถ้ารั่วไปเรื่อย ๆ → แอปกิน RAM → ค้าง → Crash (SIGABRT)

//💣 ตัวอย่างปัญหายอดฮิต: Strong Reference Cycle


class User {
    var profile: Profile?
}

class Profile0 {
    var user: User?
}

//✅ วิธีแก้: ใช้ weak หรือ unowned
class Profile {
    weak var user: User? // ✅ ป้องกัน retain cycle
}

//⚙️ 2. CPU Usage (Time Profiler)
//💬 CPU Usage คืออะไร?
//
//CPU ทำหน้าที่ประมวลผลโค้ดของคุณ —
//ถ้าใช้งานหนักเกินไป → Frame drop, UI กระตุก, battery drain

//🔍 ตรวจด้วย “Time Profiler”
//ขั้นตอน:
//Product → Profile → Time Profiler
//Instruments จะ record CPU sampling ทุก 1ms
//ดู “Call Tree” → ดูว่าฟังก์ชันไหนใช้ CPU เยอะที่สุด
//พับ/ขยาย stack trace เพื่อดูจุดที่ใช้เวลานาน

//ตัวอย่าง:
//for i in 0..<100_000_000 {
//    _ = sqrt(Double(i))
//}

//ถ้าโค้ดนี้อยู่ใน viewDidLoad → CPU spike 100% ทันที
//แก้โดย:
//ย้ายไป background thread (Task { ... })
//หรือใช้ async/await แยกออกจาก main queue

//📊 เคล็ดลับดู CPU ใน Instruments
//Filter: “Main Thread” เพื่อดูว่ามีอะไร block UI
//“Heavy” tab: บอกเปอร์เซ็นต์ของเวลา CPU ใช้ใน function ไหน
//ปรับ sampling interval ให้ละเอียดขึ้นได้ (default: 1ms)

//🧩 3. การใช้ Memory (Allocations)
//🔹 เปิดด้วย “Allocations Instrument”
//ใช้เพื่อ:
//ดูว่า object ไหนกินหน่วยความจำเยอะ
//ตรวจว่า instance ของ class ถูกสร้างซ้ำมากเกินไปไหม
//ดูการเพิ่ม/ลดหน่วยความจำเมื่อเปลี่ยนหน้า
//ดูได้จาก:
//“Live Bytes” (หน่วยความจำที่ใช้อยู่ตอนนี้)
//“Persistent” (หน่วยความจำที่ยังไม่คืน)
//“Transient” (ชั่วคราว)

//🧠 วิธีวิเคราะห์ Memory Leak + Allocations
//เปิด Allocations + Leaks
//กด Record ▶️
//ใช้งานแอป → เปิด/ปิดหน้าจอหลาย ๆ รอบ
//ดู memory graph → ถ้า memory ไม่ลดลงหลังออกจากหน้า → Leak!

//💡 เครื่องมือใน Xcode ที่ช่วยอีกตัว: “Memory Graph Debugger”
//รันแอปใน Debug mode
//ที่แถบ Debug Area → คลิกปุ่มรูปเพชร (🟣)
//Xcode จะโชว์กราฟความสัมพันธ์ของ object ทั้งหมด
//Object ที่ “retain cycle” จะแสดงด้วยสีม่วง

//🧠 5. การตรวจ Performance ทั้งระบบ
//🧩 Activity Monitor (ใน Instruments)
//ดูภาพรวมการใช้ CPU, Memory, Disk, Network
//ใช้ตอนต้องวัด performance ของแอปในระยะยาว
//🧩 Energy Log
//วัดพลังงาน, การใช้ sensor, background activity
//ใช้ตอนทำแอปที่ต้องการประหยัดแบต (เช่น fitness, GPS)

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func exampleTapped(_ sender: Any) {
        example()
    }
    
    func example() {
        var user: User? = User()
        var profile: Profile? = Profile()
        user?.profile = profile
        profile?.user = user

        user = nil
        profile = nil // ❌ ทั้งคู่ไม่ถูกลบ เพราะอ้างถึงกัน
//        ➡️ เกิด “retain cycle” → Memory leak
    }
}

//🔬 ตัวอย่างการแก้ Leak จริงใน UIKit
//❌ ปัญหา: Timer จับ self แบบ strong → Controller ไม่เคย deinit
class MyViewController: UIViewController {
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            print("Tick")
        }
        
//        ✅ แก้ไข:
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            self?.doSomething()
        }
    }

    deinit {
        print("✅ Deallocated")
    }
}

//อยากไหมครับให้ผมทำ Workshop เล็ก ๆ
//👉 ตัวอย่างจริง “แอปที่มี memory leak” แล้วใช้ Instruments แก้ให้เห็น step-by-step
//(เห็นชัดมากว่ามันรั่วจากไหน แล้วแก้ยังไง)


