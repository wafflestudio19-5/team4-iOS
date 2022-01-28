//
//  Dictionary+urlqueryItems.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/29.
//

import Foundation
import UIKit

extension Dictionary {

    public var urlQueryItems: [URLQueryItem]? {
        let queryItems = self.map { (key, value) in
            URLQueryItem(name: String(describing: key),
                         value: String(describing: value))
        }
        return queryItems
    }
}

extension Dictionary where Key == String, Value == Any? {
    public func filterNil() -> [String:Any]? {
        let filteredNil = self.filter({ $0.value != nil }).mapValues({ $0! })
        return (!filteredNil.isEmpty) ? filteredNil : nil
    }
}
