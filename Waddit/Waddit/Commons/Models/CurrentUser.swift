//
//  CurrentUser.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import Foundation

class CurrentUser {

    static let shared = CurrentUser()

    private init() { }

    var profile: User?


}
