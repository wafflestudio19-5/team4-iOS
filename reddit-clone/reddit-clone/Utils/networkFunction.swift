import Foundation

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
        print(accessToken)
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
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
}
