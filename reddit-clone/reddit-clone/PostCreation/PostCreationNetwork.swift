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

extension PostCreationViewController {
    func jsonEncoding(postData: PostData) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
        }
        return data
    }
    
    func networkRequest(data: Data) {
        NetworkFunc.requestPost(url: "/api/v1/posts/", sendData: data) { (response, data) in
            print("================")
            print(response)
            print(data)
            print("===============")
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
