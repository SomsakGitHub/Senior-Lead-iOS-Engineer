//🧭 ทำความเข้าใจ "Coordinator Pattern"
//🎯 ปัญหาก่อนใช้
//โดยปกติ ViewController มักจะทำทุกอย่างเอง:

//❌ ปัญหา:
//ViewController ต้องรู้จัก “หน้าถัดไป” → tightly coupled
//ถ้า flow ซับซ้อน เช่น tab bar, modal, nested navigation → โค้ดรกมาก
//ยากต่อการ reuse และ test

//✅ แนวคิดของ Coordinator Pattern
//“แยกความรับผิดชอบของการนำทาง (navigation logic) ออกจาก ViewController”
//ให้ class พิเศษชื่อ Coordinator เป็นผู้ดูแลแทน

//🧩 โครงสร้างหลัก
//AppCoordinator
// ├── LoginCoordinator
// ├── HomeCoordinator
// └── SettingCoordinator

//แต่ละ Coordinator:
//รู้จักว่ามี ViewController อะไรใน flow นั้น
//สร้างและเชื่อมต่อ ViewController ให้กัน
//จัดการการ push / present / dismiss

class LoginViewController: UIViewController {
    func goToHome() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

//💡 ตัวอย่างการใช้งานจริง (UIKit)
//🔹 Step 1: สร้าง Protocol Coordinator
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

//🔹 Step 2: สร้าง AppCoordinator
class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
}

//🔹 Step 3: สร้าง LoginCoordinator
class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LoginViewControllero()
        vc.onLoginSuccess = { [weak self] in
            self?.goToHome()
        }
        navigationController.setViewControllers([vc], animated: false)
    }

    func goToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}

//🔹 Step 4: ViewController สื่อสารผ่าน callback
class LoginViewControllero: UIViewController {
    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.center = view.center
        button.frame = CGRect(x: 100, y: 300, width: 100, height: 40)
        view.addSubview(button)
    }

    @objc func loginTapped() {
        onLoginSuccess?()
    }
}

//🔹 Step 5: สร้าง HomeCoordinator + HomeViewController
class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Home"
    }
}

//🔹 Step 6: เริ่มต้นที่ SceneDelegate (หรือ AppDelegate)
//✅ ผลลัพธ์
//LoginViewController ไม่ต้องรู้จัก HomeViewController เลย
//การนำทางทั้งหมดถูกจัดการโดย Coordinator
//การเปลี่ยน flow หรือเพิ่ม flow ใหม่ ง่ายมาก

//🔧 ใช้ร่วมกับ MVVM
//ใน MVVM แต่ละ ViewModel อาจไม่รู้ว่าต้องนำทางไปไหน → Coordinator จะทำแทน

class LoginViewModel {
    var onLoginSuccess: (() -> Void)?

    func login() {
        // ตรวจสอบสำเร็จ
        onLoginSuccess?()
    }
}

class LoginViewController1: UIViewController {
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLoginSuccess = { [weak self] in
            self?.onLoginSuccess?()
        }
    }

    var onLoginSuccess: (() -> Void)?
}
//➡️ จากนั้น Coordinator จะรับ callback แล้วนำทางไปยังหน้า Home
//ไม่ต้องให้ ViewModel หรือ ViewController รู้จัก Home เลย ✅

//อยากให้ผมต่อด้วยตัวอย่าง Coordinator + MVVM (ครบ flow Login → Home พร้อม ViewModel) ไหมครับ?
//จะเห็นว่าเมื่อรวมกันแล้ว app architecture จะ “สะอาดและ test ได้สุด ๆ” 🧼💪

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

