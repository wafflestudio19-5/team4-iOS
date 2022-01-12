//
//  Endpoint.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import Foundation


protocol Endpoint {
    //var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + path
    }
}
