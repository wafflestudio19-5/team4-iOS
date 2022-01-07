import Foundation
import UIKit

struct userInfo: Codable {
    let id: Int
    let username: String
    let email: String
    let date_joined: String
}

extension ProfileMainViewController {
    func jsonDecoding(_data: Data) -> userInfo? {
        guard let getData = try? JSONDecoder().decode(userInfo.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func networkRequest(_token: String?) {
        if _token == nil {return}
        NetworkFunc.requestGetWithToken(url: "/api/v1/users/me/", accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get user profile success")
                guard let returnData = self.jsonDecoding(_data: data) else {return}
                self.userNameLabel.text = "u/" + returnData.username
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                let date = dateFormatter.date(from: returnData.date_joined)
                
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let dateString:String = dateFormatter.string(from: date!)
                
                self.joinDateLabel.text = "Joined at " + dateString
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
