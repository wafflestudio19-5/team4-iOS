import UIKit
import Foundation

struct SignUp_UserData: Codable {
    let email: String
    let username: String
    let password: String
}

struct SignUp_Result: Codable {
    let id: Int
    let username: String
    let email: String
    let date_joined: String?
}

struct SignUp_Error: Codable {
    let error_code: Int
    let error_message: String
    let detail: String
}

extension SignUpViewController {
    func jsonParsing(data: Data) -> Any? {
        guard let output = try? JSONDecoder().decode(SignUp_Result.self, from: data) else {
            print("Error: JSON Parsing failed")
            return nil
        }
        return output
    }
    
    func jsonEncoding(param: SignUp_UserData) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
    
    func networkRequest(postData: Data) {
        NetworkFunc.requestPost(url: "/api/v1/users/", sendData: postData) { (response, data) in
            DispatchQueue.main.async {
                let resultData: SignUp_Result = self.jsonParsing(data: data) as! SignUp_Result
                print(resultData)
                if let tokenData = response.value(forHTTPHeaderField: "Authentication") {
                    print("token: " + tokenData)
                    self.token = tokenData
                    self.delegate?.SendLoginData(_id: resultData.username, _token: self.token!)
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
