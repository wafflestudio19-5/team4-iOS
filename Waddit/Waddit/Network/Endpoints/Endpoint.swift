//
//  Endpoint.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import Foundation


protocol EndpointProtocol {
    //var httpMethod: HTTPMethod { get }
    var path: String { get set }
    var headers: [String: Any]? { get set }
    var body: [String: Any]? { get set }

}

struct EndPoint: EndpointProtocol {
    var path: String
    var headers: [String: Any]?
    var body: [String: Any]?

    var queryItems: [URLQueryItem] = []

    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = NetworkConstants.releaseIP
        components.path = "/api/v1" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL Components: \(components)"
            )
        }

        return url
    }

}
