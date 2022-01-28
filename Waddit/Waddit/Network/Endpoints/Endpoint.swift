//
//  Endpoint.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import Foundation
import Alamofire


enum UrlParams: String {
    typealias RawValue = String

    case lastCommunityId
    case size
    case topicId
    case keyword


}


protocol EndpointProtocol {
    var path: String { get set }
    var headers: [String: Any]? { get set }

}

struct EndPoint: EndpointProtocol {
    var path: String
    var headers: [String: Any]?

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

    static var httpHeader: HTTPHeaders? {
        guard let token = UserManager.token else { return nil}

        let header: HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/json"
        ]

        return header
    }

}
