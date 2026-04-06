//
//  TableViewController.swift
//  TableView-List
//
//  Created by tiscomacnb2486 on 30/10/2568 BE.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = ["🍎 Apple", "🍌 Banana", "🍇 Grape", "🍊 Orange"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

//    🧱 Part 1: UITableView (UIKit)
//
//    💡 UITableView ใช้สำหรับ “แสดงข้อมูลเป็นแถว ๆ”
//    ต้องกำหนดว่า “มีข้อมูลกี่แถว” และ “แต่ละแถวแสดงอะไร”
    
//    ✅ ขั้นตอนการใช้ TableView
//
//    สร้าง UITableView
//
//    ตั้ง dataSource และ delegate
//
//    กำหนด cell (เนื้อหาแต่ละแถว)
//
//    แสดงข้อมูล
    
//    🔹 UITableViewDataSource → บอกข้อมูล
//    🔹 UITableViewDelegate → จัดการการแตะ/เลือก
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.text = items[indexPath.row]
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("คุณเลือก: \(items[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
