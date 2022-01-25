import Foundation
import Alamofire

struct PostListResponseList: Codable {
    let response: [PostData]
}

struct PostData: Codable {
    let id: Int
    let userId: Int
    let userName: String
    let userImageUrl: String
    let title: String
    let text: String
    let images: String
    let numUpVotes: Int
    let numDownVotes: Int
    let createdAt: String
}

extension LatestSortFeedViewController {
    public func getData(pageNum: Int) {
        if defaults.string(forKey: "token") == nil { return }
        if defaults.string(forKey: "token") == "" { return }
        let ipAdress = "54.180.132.95"
        let apiURL = "/api/v1/posts/"
        var url: String
        if pageNum == 0 { url = "http://" + ipAdress + apiURL } else {url = "http://" + ipAdress + apiURL + String(pageNum)}
        let headers: HTTPHeaders = [
            "Authorization": defaults.string(forKey: "token")!,
            "Accept": "application/json"
        ]
        var parameters: String? = String(pageNum)
        if pageNum == 0 {
            parameters = "Long.max"
        }
        AF.request(url, headers: headers).responseData() { (response) in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(PostListResponseList.self, from: jsonData)
                    print(json)
                }
                catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(response.response?.statusCode)
            }
        }
    }
}
