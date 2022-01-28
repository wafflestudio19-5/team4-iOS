//
//  File.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/29.
//

import Foundation

struct UserManager {

    private static let userKey = "CurrentUser"
    private static let tokenKey = "Token"
    private static let isLoggedInKey = "isLoggedIn"

    static var isLoggedIn: Bool {
        get {
            guard let isLoggedIn = UserDefaults.standard.value(forKey: isLoggedInKey) as? Bool else { return false }
            return isLoggedIn
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: isLoggedInKey)
        }
    }

    static var token: String? {
        get {
            do {
                return try UserDefaults.standard.object(forKey: tokenKey) as? String
            } catch {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }

    static var cachedUser: User? {
        get {
            let data = UserDefaults.standard.value(forKey: userKey) as? Data
            return try? JSONDecoder().decode(User.self, from: data!)
        }

        set {
            let currentUserData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(currentUserData, forKey: userKey)
        }
    }
}
