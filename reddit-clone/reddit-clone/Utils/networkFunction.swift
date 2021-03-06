import Foundation
import Alamofire

protocol json {
    func jsonParsing(data: Data) -> Any
    func jsonEncoding(param: Any) -> Data
}

struct NetworkFunc {
    
    static func requestGet(url: String, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        
        let ip = "54.180.132.95"
        
        guard let url = URL(string: "http://" + ip + url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
    
    static func requestGetWithToken(url: String, accessToken: String, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        
        let ip = "54.180.132.95"
        
        guard let url = URL(string: "http://" + ip + url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
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
                dump(data)
                return
            }
            
            completionHandler(response, data)
        }.resume()
    }
    
    static func requestPost(url: String, sendData: Data, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        let ip = "54.180.132.95"
        
        /*
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
        }
         */
        
        guard let url = URL(string: "http://" + ip + url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = sendData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                failure()
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                failure()
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                print(response)
                failure()
                return
            }
            print(response)
            completionHandler(response, data)
        }.resume()
    }
    
    static func requestPostWithToken(url: String, sendData: Data, accessToken: String, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        let ip = "54.180.132.95"
        
        guard let url = URL(string: "http://" + ip + url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(accessToken, forHTTPHeaderField: "Authentication")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = sendData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                failure()
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                failure()
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                print(response)
                failure()
                return
            }
            print(response)
            completionHandler(response, data)
        }.resume()
    }
    
    static func requestPutWithToken(url: String, sendData: Data, accessToken: String, completionHandler: @escaping (HTTPURLResponse, Data) -> Void, failure: @escaping () -> ()) {
        let ip = "54.180.132.95"
        
        guard let url = URL(string: "http://" + ip + url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue(accessToken, forHTTPHeaderField: "Authentication")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = sendData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            dump(request)
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                failure()
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                failure()
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                print(response)
                dump(data)
                failure()
                return
            }
            print(response)
            completionHandler(response, data)
        }.resume()
    }
    
    static func imageUpload(url: String, uploadImage: UIImage) {
        let uploadUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let imageData = uploadImage.jpegData(compressionQuality: 0.4) else { return }

        AF.upload(imageData, to: URL(string: url)!, method: .put).responseJSON { (response) in
            switch response.result {
            case .success(let res):
                do {
                print(response.response)
                }
            case .failure(let err):
                print(response.response?.statusCode)
            }
        }
    }
    static func imageDownload(url: String) -> UIImage? {
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
    }}
