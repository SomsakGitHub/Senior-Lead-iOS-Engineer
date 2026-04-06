//
//  ViewController.swift
//  UnitTestingUITesting
//
//  Created by somsak02061 on 4/11/2568 BE.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        🧩 ตั้งค่า Accessibility Identifier
//        ใน Interface Builder หรือโค้ด:
        titleLabel.accessibilityIdentifier = "TitleLabel"
    }
    
    @IBAction func changeTextTapped(_ sender: UIButton) {
        titleLabel.text = "Hello iOS!"
    }
}

