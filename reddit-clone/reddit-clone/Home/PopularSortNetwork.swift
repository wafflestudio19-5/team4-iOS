import Foundation
import UIKit

struct postList: Codable {
    let results: [PostGetData]
    let count: Int
}

extension PopularSortViewController {
    func jsonDecoding(_data: Data) -> postList? {
        guard let getData = try? JSONDecoder().decode(postList.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
    
    func networkRequest(_token: String?) {
        if _token == nil {return}
        NetworkFunc.requestGetForPopularSort(url: "/api/v1/posts/", accessToken: _token!, lastPostID: self.postDataList.count + 1) { (response, data) in
            DispatchQueue.main.async {
                print("Get post List success")
                let returnData = self.jsonDecoding(_data: data)
                print(returnData)
                if (returnData?.results.count != 0) {
                    for i in 0 ... ((returnData?.results.count)! - 1) {
                        self.postDataList.append((returnData?.results[i])!)
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
    static func requestGetForPopularSort(url: String, accessToken: String, lastPostID: Int, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        
        let ip = "54.180.132.95"
        
        let url = "http://" + ip + "/api/v1/posts/"
        var components = URLComponents(string: url)
        let lastPostIndex = URLQueryItem(name: "lastPostId", value: String(lastPostID))
        components?.queryItems = [lastPostIndex]

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
            
            /*
             guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
                 print("Error: JSON Parsing failed")
                 return
             }
            */
            
            completionHandler(response, data)
        }.resume()
    }
}
