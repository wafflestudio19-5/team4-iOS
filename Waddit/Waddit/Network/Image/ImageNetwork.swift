import Foundation
import Alamofire

struct ImageNewtork {
    func imageUpload(url: String, uploadImage: UIImage) {
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        let imageData = uploadImage.jpegData(compressionQuality: 0.5)!
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "activityImage", fileName: "\(uploadImage).png", mimeType: "image/png")
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(PostListResponseList.self, from: jsonData)
                    print(json)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(response.response?.statusCode)
            }
        }
    }
    func imageDownload(url: String) -> UIImage? {
        var downloadImage: UIImage?
        AF.request(url).responseData() {(response) in
            switch response.result {
            case .success(let responseData):
                downloadImage = UIImage(data: responseData, scale: 1)
            case .failure(let error):
                print(error)
                downloadImage = nil
            }
        }
        return downloadImage
    }
}
