import Foundation
import UIKit

struct UserInfoChange: Codable {
    let email: String?
    let username: String?
    let password: String?
}

struct UserInfoChangeImage: Codable {
    let filename: String
}

struct UserInfoChangeEmail: Codable {
    let email: String
}

struct UserInfoChangeUserName: Codable {
    let username: String
}

struct UserInfoChangePassWord: Codable {
    let password: String
}

struct UserImageLink: Codable {
    let preSignedUrl: String
}

extension ProfileModifyViewController {
    
    func jsonEncoding(postData: UserInfoChange) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingEmail(postData: UserInfoChangeEmail) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingName(postData: UserInfoChangeUserName) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingPassWord(postData: UserInfoChangePassWord) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonEncodingImage(postData: UserInfoChangeImage) -> Data? {
        guard let data = try? JSONEncoder().encode(postData) else {
            print("Error: Encoding Failed")
            return nil
            }
        return data
        }
    
    func jsonDecoding(_data: Data) -> UserImageLink? {
        guard let getData = try? JSONDecoder().decode(UserImageLink.self, from: _data) else {
            print("Error: Decoding Failed")
            return nil
        }
        return getData
    }
        
    func networkRequest(data: Data, token: String?) {
        if token == nil { return }
        
        NetworkFunc.requestPutWithToken(url: "/api/v1/users/me/", sendData: data, accessToken: token!) { (response, data) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "user update success", preferredStyle: UIAlertController.Style.alert)
                let completeAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                })
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
    
    static func requestGetPhotos(url: String, accessToken: String, sendData: Data, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        
        let ip = "54.180.132.95"
        
        let urlString = "http://" + ip + "/api/v1/users/profile/image/"
        
        var components = URLComponents(string: urlString)
        let fileName = URLQueryItem(name: "filename", value: "profile.png")
        components?.queryItems = [fileName]

        guard let newURL = components?.url else {
            return
        }

        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "Authentication")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            dump(request)
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
    
    func networkRequestPhotos(data: Data, token: String?) {
        if token == nil { return }
        
        ProfileModifyViewController.requestGetPhotos(url: "/api/v1/users/profile/image/", accessToken: token!, sendData: data) { (response, data) in
            DispatchQueue.main.async {
                guard let returnData = self.jsonDecoding(_data: data) else {return}
                print(returnData)
                
                //let alert = UIAlertController(title: "Success", message: "user update success", preferredStyle: UIAlertController.Style.alert)
                
                /*
                let image : UIImage = self.selectImageView.image!
                let imageData = image.pngData()
                
                var postDataImage: UserInfoChangeImage
                postDataImage = UserInfoChangeImage(filename: imageData!)
                guard let postData = self.jsonEncodingImage(postData: postDataImage) else {return}
                 */
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

extension String {
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return ""
    }
}
