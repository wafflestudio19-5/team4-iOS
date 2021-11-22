//
//  FindPWViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/22.
//

import UIKit

class FindPWViewController: UIViewController {
    // let labelFrame = CGRect(x: 50, y: 50, width: 200, height: 40)
    let label = UILabel(frame: CGRect(x: 50, y: 50, width: 500, height: 300))
    
    let button = UIButton(frame: CGRect(x: 50, y: 350, width: 200, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setLabel()
        setView()
        setButton()
        self.view.addSubview(label)
        self.view.addSubview(button)
    }
    
    func setView() {
        self.view.backgroundColor = .white
    }
    
    func setLabel() {
        self.label.text = "This is find password page"
        self.label.numberOfLines = 3
    }
    
    func setButton() {
        self.button.setTitle("Back", for: .normal)
        self.button.backgroundColor = .green
        self.button.addTarget(self, action: #selector(backActBT), for: .touchUpInside)
    }
    
    @objc func backActBT() {
        print("pressed back")
        self.presentingViewController?.dismiss(animated: true)
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
