//
//  DetailViewController.swift
//  Navigation-TabBar-Modal
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigationButtonTapped(_ sender: Any) {
        let swiftUIView = Navigation()
        pushViewController(rootView: swiftUIView)
    }
    
    func pushViewController<Content: View>(rootView: Content) {
        let hostingController = UIHostingController(rootView: rootView)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
