//
//  ViewController.swift
//  Navigation-TabBar-Modal
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        1. Navigation Controller
//
//        ใช้สำหรับ “เลื่อนหน้าเข้า–ออก” แบบ stack
//        เช่นจากหน้า A → หน้า B → หน้า C
//        แล้วสามารถกด Back กลับได้
        
//        ✅ ตัวอย่างพื้นฐาน (UIKit)
//        let nextVC = DetailViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
        
//    กลับหน้าเดิม:
//        navigationController?.popViewController(animated: true)

//        🧱 ตั้งชื่อหัวข้อ (Navigation Bar Title)
        title = "รายละเอียด"
        view.backgroundColor = .systemBackground
        
//        🧰 ใส่ปุ่มขวาบน (Bar Button Item)
        UIBarButtonItemSetting()
    }
    
    func UIBarButtonItemSetting(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "เพิ่ม",
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
    }

    @objc func addTapped() {
        print("กดปุ่มเพิ่ม")
    }
    
    @IBAction func mainViewButtonTapped(_ sender: Any) {
        let swiftUIView = MainView()
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {
        let hostingController = UIHostingController(rootView: rootView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

