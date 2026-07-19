//🧱 โครงสร้าง
//View ↔ Presenter ↔ Interactor ↔ Entity
//         ↕
//        Router

//🧩 ตัวอย่าง VIPER (ภาพรวม)
//Login Module
// ├── LoginViewController (View)
// ├── LoginPresenter
// ├── LoginInteractor
// ├── LoginRouter
// └── UserEntity

//อยากให้ผมทำตัวอย่าง “เปรียบเทียบ MVVM vs VIPER ใน feature เดียวกัน” (เช่น หน้าล็อกอิน) ให้ไหมครับ?
//จะเห็นความแตกต่างของ architecture แบบชัดเจนสุดเลย 👀

//🔸 LoginEntity.swift
struct UserEntity {
    let username: String
    let token: String
}

//🔸 LoginInteractor.swift
protocol LoginInteractorProtocol {
    func login(username: String, password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol?
    
    func login(username: String, password: String) {
        // สมมติเรียก API สำเร็จ
        let user = UserEntity(username: username, token: "abc123")
        presenter?.loginSucceeded(user: user)
    }
}

//🔸 LoginPresenter.swift
protocol LoginPresenterProtocol {
    func loginSucceeded(user: UserEntity)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    func login(username: String, password: String) {
        interactor?.login(username: username, password: password)
    }
    
    func loginSucceeded(user: UserEntity) {
        view?.showWelcomeMessage("Welcome \(user.username)!")
        router?.navigateToHome()
    }
}

//🔸 LoginViewController.swift
protocol LoginViewProtocol: AnyObject {
    func showWelcomeMessage(_ message: String)
}

class LoginViewController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.login(username: "admin", password: "1234")
    }

    func showWelcomeMessage(_ message: String) {
        print(message)
    }
}

//🔸 LoginRouter.swift
protocol LoginRouterProtocol {
    func navigateToHome()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToHome() {
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .systemGreen
        viewController?.navigationController?.pushViewController(homeVC, animated: true)
    }
}

import SwiftUI

struct SwiftUiViperView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SwiftUiViperView()
}
