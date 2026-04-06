//
//  ViewController.swift
//  IBOutlet-IBAction
//
//  Created by tiscomacnb2486 on 30/10/2568 BE.
//

import UIKit

class ViewController: UIViewController {

    //    🎨 แนวคิดเบื้องต้น
    //
    //    ใน Storyboard หรือ XIB,
    //    เราสามารถสร้าง UI เช่น UILabel, UIButton, UIImageView
    //    แต่ถ้าอยาก เข้าถึงหรือควบคุม มันในโค้ด — เราต้อง “เชื่อม”
        
    ////    🧩 1. IBOutlet (Interface Builder Outlet)
    //    ใช้เชื่อม UI Component จาก Storyboard → Code
    //    เพื่ออ่านหรือเปลี่ยนค่าของมันได้
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        🧠 การใช้งาน
        button.titleLabel?.text = "สวัสดี Swift!"
        button.backgroundColor = .systemBlue
        
//        ✅ เราสามารถเปลี่ยนข้อความ สี หรือฟอนต์ จากโค้ดได้โดยตรง
    }

//    2. IBAction (Interface Builder Action)
//    ใช้เชื่อม Event จาก UI → Function ในโค้ด
//    เช่น เมื่อกดปุ่ม หรือเลื่อนสวิตช์
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("ปุ่มถูกกด!")
        button.titleLabel?.text = "คุณกดปุ่มแล้ว 🎉"
    }
}

