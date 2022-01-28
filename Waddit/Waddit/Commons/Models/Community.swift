//
//  File.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/29.
//

import Foundation

struct Community: Codable, Identifiable {
    let id: Int
    let name: String
    let num_members: Int
    let num_managers: Int
    let description: String
    let deleted: Bool
}

struct CommunityList: Codable {
    let content: [Community]?
    let size: Int
    let numberOfElements: Int
    let links: [String: String]
}
