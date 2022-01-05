import Foundation
import UIKit

struct PostGetData: Codable {
    let id: Int
    let userId: Int
    let title: String
    let text: String
    let images: [String]
    let numUpVotes: Int
    let numDownVotes: Int
}

extension PostViewController {
    func jsonDecoding(_data: Data) -> PostGetData? {
        guard let getData = try? JSONDecoder().decode(PostGetData.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func networkRequest(_token: String?) {
        if _token == nil {return}
        NetworkFunc.requestGetWithToken(url: "/api/v1/posts/1/", accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get community data success")
                let returnData = self.jsonDecoding(_data: data)
                self.postTitleLabel.text = returnData?.title
                self.postDataLabel.text = returnData?.text
                let upNum = returnData?.numUpVotes
                let downNum = returnData?.numDownVotes
                self.voteUpNumLabel.text = String(upNum!)
                self.voteDownNumLabel.text = String(downNum!)
                //MARK: - set postHeight
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
