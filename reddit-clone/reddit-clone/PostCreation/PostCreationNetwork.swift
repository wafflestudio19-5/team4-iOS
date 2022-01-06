import Foundation
import UIKit

struct PostSendData_text: Codable {
    let title: String
    let text: String
    let community: String
}

struct PostSendData_image: Codable {
    let title: String
    let images: [String]
    let community: String
}

extension PostCreationViewController {
    func jsonEncodingText(param: PostSendData_text) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
    
    func jsonEncodingImage(param: PostSendData_image) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
    
    func networkRequestText(_data: Data, _token: String?) {
        if _token == nil {return}
        NetworkFunc.requestPostWithToken(url: "/api/v1/posts/", sendData: _data, accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get community data success")
                let alert = UIAlertController(title: "Success", message: "post create success", preferredStyle: UIAlertController.Style.alert)
                    let completeAction = UIAlertAction(title: "OK", style: .default)
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
