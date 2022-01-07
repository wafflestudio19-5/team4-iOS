import Foundation
import UIKit

struct UserInfoChange: Codable {
    let email: String?
    let username: String?
    let password: String?
}


struct UserInfoChangeEmail: Codable {
    let email: String
}

struct UserInfoChangeUserName: Codable {
    let username: String
}

struct UserInfoChangePassWord: Codable {
    let password: String
}

extension ProfileModifyViewController {
    
    func jsonEncoding(postData: UserInfoChange) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingEmail(postData: UserInfoChangeEmail) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingName(postData: UserInfoChangeUserName) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingPassWord(postData: UserInfoChangePassWord) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
        
    func networkRequest(data: Data, token: String?) {
        if token == nil { return }
        
        NetworkFunc.requestPutWithToken(url: "/api/v1/users/me/", sendData: data, accessToken: token!) { (response, data) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "user update success", preferredStyle: UIAlertController.Style.alert)
                let completeAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                })
                alert.addAction(completeAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
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
