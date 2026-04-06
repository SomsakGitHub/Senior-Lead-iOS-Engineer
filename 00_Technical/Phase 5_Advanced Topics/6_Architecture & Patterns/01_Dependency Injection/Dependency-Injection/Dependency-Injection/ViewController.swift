//💡 แนวคิดพื้นฐานของ Dependency Injection
//ก่อนอื่น มาดูคำว่า Dependency ก่อน 👇
//“Dependency” คือสิ่งที่คลาสหนึ่ง พึ่งพา (depend on) เพื่อทำงานได้
//เช่น:

//🧨 ปัญหา:
//ProfileViewModel สร้าง UserService ภายในตัวเอง
//→ ทำให้ เปลี่ยน service ไม่ได้
//→ ทดสอบไม่ได้ เพราะไม่สามารถ mock UserService ได้

//✅ แนวทางแก้: Dependency Injection
//คือ “การส่ง dependencies เข้ามาจากภายนอก”
//แทนที่จะสร้างเองภายใน class

//    🧠 ตัวอย่างเปรียบเทียบ
//    ❌ ไม่ใช้ DI
//    class UserRepository {
//        func fetchUser() -> String {
//            "👤 Somsak"
//        }
//    }
//
//    class ProfileViewModel {
//        let repository = UserRepository()
//
//        func getUser() {
//            print(repository.fetchUser())
//        }
//    }
//
//    ถ้าเราต้องการ mock UserRepository ตอน unit test → ทำไม่ได้ 😩

class UserService {
    func fetchUser() -> String {
        return "👤 Somsak"
    }
}

class ProfileViewModel {
    let service = UserService() // ← dependency
}

class ProfileViewModel0 {
    private let service: UserService

    init(service: UserService) {
        self.service = service
    }

    func loadProfile() {
        print(service.fetchUser())
    }
}

class ProfileViewModel1 {
    var service: UserService?
    
    func loadProfile() {
        guard let service = service else { return }
        print(service.fetchUser())
    }
}

class ProfileViewModel2 {
    func loadProfile(using service: UserService) {
        print(service.fetchUser())
    }
}

protocol UserRepositoryProtocol {
    func fetchUser() -> String
}

class UserRepository: UserRepositoryProtocol {
    func fetchUser() -> String {
        "👤 Somsak"
    }
}

// Mock สำหรับทดสอบ
class MockUserRepository: UserRepositoryProtocol {
    func fetchUser() -> String {
        "🧪 Mock User"
    }
}

class ProfileViewModel3 {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func getUser() {
        print(repository.fetchUser())
    }
}

class AppContainer {
    static let shared = AppContainer()
    
    private init() {}
    
    lazy var userRepository: UserRepositoryProtocol = UserRepository()
    lazy var profileViewModel = ProfileViewModel3(repository: userRepository)
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //🔹 1. Constructor Injection (นิยมที่สุด)
    //ส่ง dependency ผ่าน initializer
    // ใช้งานจริง
//ข้อดี:
//เห็น dependencies ชัดเจน
//เหมาะกับ testing → สามารถส่ง mock object เข้าแทนได้
    func doSomething() {
        let viewModel = ProfileViewModel0(service: UserService())
        viewModel.loadProfile()
    }
    
    //    🔹 2. Property Injection
    //    ใช้การกำหนด property หลังสร้าง object
//ข้อดี:
//ใช้ง่ายเมื่อ dependency ยังไม่พร้อมตอนสร้าง object
//ข้อเสีย:
//เสี่ยงลืม inject → ทำให้ crash ได้ถ้า nil
    func doSomething0() {
        let viewModel = ProfileViewModel1()
        viewModel.service = UserService() // inject ภายหลัง
        viewModel.loadProfile()
    }
    
//    🔹 3. Method Injection
//    ส่ง dependency ตอนเรียกใช้ method
//ข้อดี:
//ใช้ง่ายในกรณีชั่วคราว
//ข้อเสีย:
//ต้องส่ง dependency ทุกครั้ง → เหมาะเฉพาะบางเคส
    func doSomething1() {
        let viewModel = ProfileViewModel2()
        viewModel.loadProfile(using: UserService())
    }
    
    //✅ ใช้ Dependency Injection + Protocol
//    ✅ ข้อดีของวิธีนี้:
//    สามารถเปลี่ยน “implementation” ได้ตามสถานการณ์
//    ViewModel ไม่รู้ว่าข้างในใช้ service จริงหรือ mock
//    เหมาะกับการทำ Unit Test หรือ Clean Architecture
    
    func doSomething2() {
        // ใช้งานจริง
        let realVM = ProfileViewModel3(repository: UserRepository())
        realVM.getUser()  // 👤 Somsak

        // ใช้ตอน Unit Test
        let testVM = ProfileViewModel3(repository: MockUserRepository())
        testVM.getUser()  // 🧪 Mock User
    }
    
//    🧩 DI Container (ระดับสูง)
//    ถ้าโปรเจ็กต์ใหญ่ — ใช้ “DI Container” จัดการ dependencies ทั้งหมด
//    เช่น:
//    หรือใช้ Framework เช่น
//    Swinject (ยอดนิยมมากใน Swift)
//    Resolver
//    Needle (Uber ใช้)
    
    func doSomething3() {
//        ใช้ใน ViewController:
        let vm = AppContainer.shared.profileViewModel
        vm.getUser()
    }

//    ⚙️ ตัวอย่าง DI + VIPER / MVVM
//    ใน MVVM
    func doSomething4() {
//        let viewModel = PostViewModel3(service: APIService())
    }
    
//    ใน VIPER
    func doSomething6() {
//        let interactor = LoginInteractor(authService: AuthService())
//        let presenter = LoginPresenter(interactor: interactor)
    }

}

