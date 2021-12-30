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
        
        //set touch recognizer
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        }
    
    override func viewWillAppear(_ animated: Bool) {
            self.addKeyboardNotifications()
            
        }
        override func viewWillDisappear(_ animated: Bool) {
            self.removeKeyboardNotifications()
        }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
}

extension SignUpViewController {
    // Adding Notification
    func addKeyboardNotifications(){
        // install handler that notifies the app when keyboard showup
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: nil)
        // install handler that notifies the app when keyboard goes down
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // Removing Notification
    func removeKeyboardNotifications(){
        // remove handler that notifies the app when keyboard showup
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        // remove handler that notifies the app when keyboard goes down
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification) {
            self.scrollView.frame.origin.y = self.view.safeAreaInsets.bottom
    }
}
