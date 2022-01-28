//
//  File.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/24.
//

import Foundation

enum MenuOptions: String, CaseIterable {
    typealias RawValue = String // 이 부분이 있어야 컴파일이 된다...

    case signUpLogIn = "Sign up / Log in"

    var imageName: String {
        switch self {
        case .signUpLogIn:
            return "person.crop.circle"
        }
    }
}
