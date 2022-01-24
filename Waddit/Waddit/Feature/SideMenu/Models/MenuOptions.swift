//
//  File.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/24.
//

import Foundation

enum MenuOptions: String, CaseIterable {
    case signUpLogIn = "Sign up / Log in"
    
    var imageName: String {
        switch self {
        case .signUpLogIn:
            return "person.circle"
        }
    }
}
