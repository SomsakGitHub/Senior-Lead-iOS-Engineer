//
//  ProgrammaticAutoLayout.swift
//  Auto Layout-SwiftUI
//
//  Created by tiscomacnb2486 on 25/10/2568 BE.
//

import UIKit

class ProgrammaticAutoLayout: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        programmaticAutoLayout()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func programmaticAutoLayout(){
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Programmatic Auto Layoutaaaa", for: .normal)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
//        ✨ Tip: ควรตั้ง translatesAutoresizingMaskIntoConstraints = false
//        เพื่อบอกให้ใช้ Auto Layout แทนระบบเก่า
    }

}
