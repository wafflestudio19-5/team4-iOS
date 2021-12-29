import UIKit
import Tabman

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
    
    var delegate: LoginProtocol? //login protocol
    var token: String? //token
    
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
    
    
    @IBAction func loginButtonTouch(_ sender: Any) {
        if (emailTF.text == nil) {return}
        if (usernameTF.text == nil) {return}
        if (passwordTF.text == nil) {return}
        
        let datatest: SignUp_UserData = SignUp_UserData(email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!)
        
        let postData = jsonEncoding(param: datatest)
        networkRequest(postData: postData!)
    }
}
