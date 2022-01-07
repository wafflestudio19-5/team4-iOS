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

struct Comment: Codable {
    let id: Int
    let userId: Int
    let text: String
    let depth: Int
    let parentId: Int
    let groupId: Int
    let numUpVotes: Int
    let numDownVotes: Int
    let deleted: Bool
}

struct CommentList: Codable {
    let results: [Comment]
}

extension PostViewController {
    func jsonDecoding(_data: Data) -> PostGetData? {
        guard let getData = try? JSONDecoder().decode(PostGetData.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func jsonDecodingComment(_data: Data) -> CommentList? {
        guard let getData = try? JSONDecoder().decode(CommentList.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func networkRequest(_token: String?) {
        if _token == nil {return}
        if postNum == nil {return}
        NetworkFunc.requestGetWithToken(url: "/api/v1/posts/" + String(postNum! + 1) + "/", accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get Post data success")
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
    
    func networkRequestComments(_token: String?) {
        if _token == nil { return }
        if postNum == nil { return }
        
        
        NetworkFunc.requestGetWithToken(url: "/api/v1/comments/" + String(postNum! + 1) + "/", accessToken: _token!) { (response, data) in
            DispatchQueue.main.async {
                print("Get comment list success")
                let returnData = self.jsonDecodingComment(_data: data)
                self.commentData = returnData?.results ?? []
                //MARK: - set postHeight
                
                self.sortComments()
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
