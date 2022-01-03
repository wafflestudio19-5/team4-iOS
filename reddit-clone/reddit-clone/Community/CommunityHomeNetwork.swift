import UIKit
import Foundation

struct community_Information: Codable {
    let id: Int
    let name: String
    let num_members: Int
    let num_managers: Int
    let description: String
    let deleted: Bool
}

extension CommunityHomeViewController {
    func jsonDecoding(_data: Data) -> community_Information? {
        guard let getData = try? JSONDecoder().decode(community_Information.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func networkRequest(_token: String?) {
        if _token == nil {return}
        NetworkFunc.requestGetWithToken(url: "/api/v1/communities/1/", accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get community data success")
                self.communityData = self.jsonDecoding(_data: data)
                if self.communityData != nil {
                    print(self.communityData)
                    self.nameLabel.text = "r/" + self.communityData!.name
                    let memberNum: String = String(self.communityData!.num_members)
                    self.memberNumLabel.text = memberNum + " members joined"
                    self.descriptionLabel.text = self.communityData?.description
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
