//
//  ViewController.swift
//  TableView-List
//
//  Created by tiscomacnb2486 on 30/10/2568 BE.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ListViewButtonTapped(_ sender: Any) {
        let swiftUIView = ListView()
        pushViewController(rootView: swiftUIView)
    }
    
    @IBAction func ListNavigationLinkTapped(_ sender: Any) {
        let swiftUIView = ListNavigationLink()
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {

        // 3. ห่อด้วย UIHostingController
        let hostingController = UIHostingController(rootView: rootView)
        
        // 4. Present แบบ modal
        present(hostingController, animated: true, completion: nil)
    }
}

