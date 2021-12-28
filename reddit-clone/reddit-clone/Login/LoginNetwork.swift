import UIKit
import Foundation

struct Login_UserData: Codable {
    let email: String
    let password: String
}

extension LogInViewController {
    func jsonEncoding(param: Login_UserData) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
    
    func networkRequest(postData: Data) {
        NetworkFunc.requestPost(url: "/api/v1/users/signin/", sendData: postData) { (response, data) in
            DispatchQueue.main.async {
                print("Login Sucess")
                if let tokenData = response.value(forHTTPHeaderField: "Authentication") {
                    print("token: " + tokenData)
                    self.token = tokenData
                }
                }
        }
        failure: {
            let alert = UIAlertController(title: "Error", message: "Error has been occured", preferredStyle: UIAlertController.Style.alert)
                let warningAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(warningAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
}
