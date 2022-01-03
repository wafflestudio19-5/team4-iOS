import UIKit
import Foundation

struct Community_SendData: Codable {
    let name: String
    let description: String
    let topics: [String]
}

extension CommunityCreateViewController {
    func jsonEncoding(param: Community_SendData) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
    
    func networkRequest(postData: Data) {
        NetworkFunc.requestPostWithToken(url: "/api/v1/communities/", sendData: postData, accessToken: token!) { (response, data) in
            DispatchQueue.main.async {
                print("Community Create Sucess")
                //self.dismiss(animated: true, completion: nil)
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityHomeVCID") as? CommunityHomeViewController else {return}
                self.present(vc, animated: true, completion: nil)
                //self.dismiss(animated: true, completion: nil)
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
