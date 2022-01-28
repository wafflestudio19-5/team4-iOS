//
//  File.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/28.
//

import Foundation

struct AuthRequestData: Codable {
    let username: String?
    let email: String
    let password: String
}

struct TokenResponse: Codable {
    let token: String
}
