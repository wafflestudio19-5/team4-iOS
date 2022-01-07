//
//  SubscriptionNetwork.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2022/01/08.
//

import UIKit
import Foundation

extension CommuListViewController {
    func jsonDecoding(_data: Data) -> CommunityList? {
        var getData: CommunityList?
        do {
            getData = try JSONDecoder().decode(CommunityList.self, from: _data)
        } catch let error {
            print("\(error)")
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func networkRequest(_token: String?) {
        if _token == nil {return}
        NetworkFunc.requestGetForCommunityList(url: "/api/v1/communities/", accessToken: _token!, lastCommunityID: self.communityList.count) { (response, data) in
            DispatchQueue.main.async {
                print("Get Community List success")
                let returnData = self.jsonDecoding(_data: data)
                print(returnData)
                if (returnData?.content.count != 0) {
                    for i in 0 ..< (returnData?.content.count)! {
                        self.communityList.append((returnData?.content[i])!)
                    }
                }
                self.paging()
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
