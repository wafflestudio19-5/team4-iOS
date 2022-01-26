import Foundation
import Alamofire

struct specificPostData: Codable {
    let id: Int
    let userId: Int
    let title: String
    let text: String
    let images: [String]
    let numUpVotes: Int
    let numDownVotes: Int
}

struct commentListData: Codable {
    let id: Int
    let userId: Int
    let userNmae: String
    let userImage: String
    let text: String
    let depth: Int
    let parentId: Int
    let groupId: Int
    let numUpVotes: Int
    let numDownVotes: Int
    let deleted: Bool
    let createdAt: String
}

extension ReadPostViewController {
    func getPostData(postNum: Int?) {
        if postNum == nil {return}
        if UserDefaults.standard.string(forKey: "token") == nil { return }
        if UserDefaults.standard.string(forKey: "token") == "" { return }
        let ipAdress = "54.180.132.95"
        let apiURL = "/api/v1/posts/"
        var url: String
        url = "http://" + ipAdress + apiURL + String(postNum!) + "/"
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey: "token")!,
            "Accept": "application/json"
        ]
        AF.request(url, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(specificPostData.self, from: jsonData)
                    
                    print(json)
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure:
                print(response.response?.statusCode)
            }
        }
    }
}
