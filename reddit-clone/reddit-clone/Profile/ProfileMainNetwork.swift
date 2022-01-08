import Foundation
import UIKit

struct userInfo: Codable {
    let userId: Int
    let name: String
    let imageUrl: String
    let description: String
    let followers: Int
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
        NetworkFunc.requestGetWithToken(url: "/api/v1/users/profile/me/", accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get user profile success")
                guard let returnData = self.jsonDecoding(_data: data) else {return}
                self.userNameLabel.text = "u/" + returnData.name
                /*
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                let date = dateFormatter.date(from: returnData.date_joined)
                
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let dateString:String = dateFormatter.string(from: date!)
                */
                let followerString = String(returnData.followers)
                self.joinDateLabel.text = followerString + "follows"
                if returnData.imageUrl != "" {
                    DispatchQueue.global().async {
                        let imageUrl = URL(string: returnData.imageUrl)
                        let imageData = try? Data(contentsOf: imageUrl!)
                        self.userImageView.image = UIImage(data: imageData!)
                    }
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
