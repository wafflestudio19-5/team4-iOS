//
//  Endpoint+Communities.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/29.
//

import Foundation

extension EndPoint {

    static func communityList(queryDict: [String : Any?]) -> Self {
        if let queryItems = queryDict.filterNil() {
            return EndPoint(path: "/communities/", queryItems: queryItems.urlQueryItems ?? [])
        } else {
            return EndPoint(path: "/communities/")
        }


    }
}


