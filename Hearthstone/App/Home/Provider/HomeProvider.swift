//
//  HomeProvider.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 20/09/22.
//

import Foundation

final class HomeProvider: RequestProvider {
    
    var httpMethod: HTTPMethod { .get }
    var body: [String : Any] { [:] }
    var endpoint: String { "info" }
}
