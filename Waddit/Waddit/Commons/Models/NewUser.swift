//
//  NewUser.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import Foundation

class NewUser: Codable {
    
    static let shared = NewUser()
    
    private init() { }
    
    var email: String?
    var username: String?
    var password: String?
    
    func reset() {
        self.email = ""
        self.username = ""
        self.password = ""
    }
}
