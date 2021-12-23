import Foundation

struct SignUp_UserData: Codable {
    let email: String
    let username: String
    let password: String
}

struct SignUp_Result: Codable {
    let id: Int
    let username: String
    let email: String
    let date_joined: String?
}

struct SignUp_Error: Codable {
    let error_code: Int
    let error_message: String
    let detail: String
}

extension SignUpViewController {
    func jsonParsing(data: Data) -> Any? {
        guard let output = try? JSONDecoder().decode(SignUp_Result.self, from: data) else {
            print("Error: JSON Parsing failed")
            return nil
        }
        return output
    }
    
    func jsonEncoding(param: SignUp_UserData) -> Data? {
        guard let sendData = try? JSONEncoder().encode(param) else {
            print("Error: Encoding Failed")
            return nil
        }
        return sendData
    }
}
