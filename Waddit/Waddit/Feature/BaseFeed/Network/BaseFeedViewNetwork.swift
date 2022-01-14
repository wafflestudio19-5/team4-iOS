import Foundation
import Alamofire

struct postListResponseList: Codable {
    
}

extension BaseFeedViewController {
    public func getData() {
        let ip = "54.180.132.95"
        let apiURL = "/api/v1/posts/"
        AF.request(ip + apiURL).responseJSON { (response) in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(postListResponseList.self, from: jsonData)
                }
                catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
