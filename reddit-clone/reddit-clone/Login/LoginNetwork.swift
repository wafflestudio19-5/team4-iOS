import UIKit
import Foundation

struct Login_UserData: Codable {
    let email: String
    let password: String
}

struct GoogleLogin_token: Codable {
    let accessToken: String
    let refreshToken: String
}

extension LogInViewController {
    func jsonEncoding(param: Login_UserData) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
    
    func jsonEncodingGoogleLogin(param: GoogleLogin_token) -> Data? {
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
                print("response")
                if let tokenData = response.value(forHTTPHeaderField: "Authentication") {
                    print("token: " + tokenData)
                    self.token = tokenData
                    let defaults = UserDefaults.standard
                    defaults.set(tokenData as String, forKey: "token")
                    self.dismiss(animated: true, completion: nil)
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
    
    func networkRequestGoogleLogin(postData: Data) {
        NetworkFunc.requestPost(url: "/api/v1/social_login/google/", sendData: postData) { (response, data) in
            DispatchQueue.main.async {
                print("Login Sucess")
                if let tokenData = response.value(forHTTPHeaderField: "Authentication") {
                    print("token: " + tokenData)
                    self.token = tokenData
                    let defaults = UserDefaults.standard
                    defaults.set(tokenData as String, forKey: "token")
                    self.dismiss(animated: true, completion: nil)
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
