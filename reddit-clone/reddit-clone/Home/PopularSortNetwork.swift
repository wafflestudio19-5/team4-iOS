import Foundation
import UIKit

struct postList: Codable {
    let results: [PostGetData]
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
        NetworkFunc.requestGetWithToken(url: "/api/v1/posts/" + "?lastPostId=" + String(self.postDataList.count) + "&size=10", accessToken: _token!) { (response, data) in
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
