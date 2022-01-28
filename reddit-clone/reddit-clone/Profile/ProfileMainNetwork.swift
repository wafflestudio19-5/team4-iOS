import Foundation
import UIKit
import Alamofire

struct userInfo: Codable {
    let user_id: Int
    let nickname: String
    let image_url: String
    let description: String
    let followers: Int
    let followings: Int
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
                self.userNameLabel.text = "u/" + returnData.nickname
                /*
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                let date = dateFormatter.date(from: returnData.date_joined)
                
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let dateString:String = dateFormatter.string(from: date!)
                */
                let followerString = String(returnData.followers)
                self.joinDateLabel.text = followerString + "follows"
                if returnData.image_url != "" {
                    AF.request(returnData.image_url).responseData() {(response) in
                        switch response.result {
                        case .success(let responseData):
                            self.userImageView.image = UIImage(data: responseData, scale: 1)
                        case .failure(let error):
                            print(error)
                        }
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
