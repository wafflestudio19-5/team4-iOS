//
//  LogInViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit

class LogInViewController: UIViewController {

    var loginView: LogInView {
        let rect = UIScreen.main.bounds
        let view = LogInView(frame: rect)

        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        navigationController?.setNavigationBarHidden(true, animated: true)

        let navBar = (view as? LogInView)?.navBar ?? {
            print("nil")
            return UINavigationBar()
        }()

        navBar.topItem?.leftBarButtonItem?.target = self
        navBar.topItem?.leftBarButtonItem?.action = #selector(didTabCancelButton)
    }

    @objc
    func didTabCancelButton() {
        if let navVC = self.navigationController {
            navVC.dismiss(animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
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
