//
//  LogInViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/22.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var headerView: UIStackView!
    @IBOutlet weak var cancelBT: UIButton!
    
    @IBOutlet weak var signupBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderView()
    }

    fileprivate func setHeaderView() {
        // cancel button
        cancelBT.setTitle("", for: .normal)
        let cancelImageConfig = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let cancelImage = UIImage(systemName: "xmark", withConfiguration: cancelImageConfig)
        cancelBT.setImage(cancelImage, for: .normal)
        cancelBT.tintColor = .systemGray
        
        // sign up button
        let font = UIFont.boldSystemFont(ofSize: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let signUpTitle = NSAttributedString(string: "Sign Up", attributes: attributes)
        signupBT.setAttributedTitle(signUpTitle, for: .normal)
        
    }
    
    @IBAction func findPassword(_ sender: Any) {
        let findpwVC = FindPWViewController()
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
