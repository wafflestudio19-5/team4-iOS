//
//  LogInViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/22.
//

import UIKit

class LogInViewController: UIViewController {
    let findpwVC = FindPWViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    /*
    @IBAction func cancelActBT(_ sender: UIButton) {
    }
    
    @IBAction func signupActBT(_ sender: Any) {
    }
    */

    @IBAction func findPassword(_ sender: Any) {
        print("tap find password")
        
        //findpwVC.modalPresentationStyle = .fullScreen
        findpwVC.modalPresentationStyle = .overCurrentContext
        //self.navigationController?.pushViewController(findpwVC, animated: true)
        present(findpwVC, animated: true)
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
