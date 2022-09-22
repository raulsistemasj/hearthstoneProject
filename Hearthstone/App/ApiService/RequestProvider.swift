//
//  RequestProvider.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 20/09/22.
//

import Foundation

public enum HTTPMethod {
    case get
    case post
    case delete
    case put
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        case .delete:
            return "DELETE"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        }
    }
}

public protocol RequestProvider {
    var httpMethod: HTTPMethod { get }
    var body: [String: Any] { get }
    var endpoint: String { get }
}
