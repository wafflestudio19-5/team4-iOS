//
//  User.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let username: String
    let profile_image: String?
}

