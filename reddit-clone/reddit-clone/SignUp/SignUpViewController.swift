import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var cancelBT: UIButton!
    @IBOutlet weak var loginBT: UIButton!
    @IBOutlet weak var continueBT: UIButton!
    @IBOutlet weak var createAccountLB: UIView!
    @IBOutlet weak var explainPolicyLB: UILabel!
    @IBOutlet weak var orLB: UILabel!
    @IBOutlet weak var redditIM: UIImageView!
    @IBOutlet weak var googleIM: UIImageView!
    @IBOutlet weak var appleIM: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set ui
        continueBT.applyGradient(colors: [UIColor.systemPink.cgColor, UIColor.systemOrange.cgColor])
        emailTF.layer.masksToBounds = true
        emailTF.layer.cornerRadius = emailTF.frame.height / 2
        usernameTF.layer.masksToBounds = true
        usernameTF.layer.cornerRadius = usernameTF.frame.height / 2
        passwordTF.layer.masksToBounds = true
        passwordTF.layer.cornerRadius = passwordTF.frame.height / 2
        emailTF.addLeftPadding()
        usernameTF.addLeftPadding()
        passwordTF.addLeftPadding()
        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
