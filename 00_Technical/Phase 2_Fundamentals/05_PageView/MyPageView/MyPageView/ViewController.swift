//
//  ViewController.swift
//  MyPageView
//
//  Created by tiscomacnb2486 on 3/12/2568 BE.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        let swiftUIView = MySwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        
        // Present the UIHostingController
        present(hostingController, animated: true, completion: nil)
    }
}

