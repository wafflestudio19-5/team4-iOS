//
//  CommunitySearchNetwork.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2022/01/07.
//

import Foundation
import UIKit

struct Community: Codable {
    let id: Int
    let name: String
    let num_memebers: Int
    let num_managers: Int
    let description: String
    let deleted: Bool
}

struct CommunityList: Codable {
    let results: [Community]
}


extension PostToCommunityViewController {
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
                if (returnData?.results.count != 0) {
                    for i in 0 ..< (returnData?.results.count)! {
                        self.communityList.append((returnData?.results[i])!)
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

extension NetworkFunc {
    static func requestGetForCommunityList(url: String, accessToken: String, lastCommunityID: Int, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping ()->()) {
        
        let ip = "54.180.132.95"
        
        let url = "http://" + ip + "/api/v1/Communities/"
        var components = URLComponents(string: url)
        
        if lastCommunityID != 0 {
            let lastCommunityIndex = URLQueryItem(name: "lastPostId", value: String(lastCommunityID + 1))
            let size = URLQueryItem(name: "size", value: String(30))
            components?.queryItems = [lastCommunityIndex, size]
        }
        
        guard let newURL = components?.url else {
            return
        }
        
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "Authentication")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: request failed")
                print(response)
                return
            }
            completionHandler(response, data)
        }.resume()
    }
}
