//
//  PostCreationNetwork.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2022/01/07.
//

import Foundation
import UIKit

struct PostData: Codable {
    let title: String
    let text: String
    let community: String
}

struct PostImgData: Codable {
    let title: String
    let images: [String]
    let community: String
}

extension PostCreationViewController {
    func jsonEncodingData(postData: PostData) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
        }
        return data
    }
    
    func jsonEncodingImg(postData: PostImgData) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
        }
        return data
    }
    
    func networkRequest(data: Data, token: String?) {
        if token == nil { return }
        
        
        NetworkFunc.requestPostWithToken(url: "/api/v1/posts/", sendData: data, accessToken: token!) { (response, data) in
            DispatchQueue.main.async {
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
