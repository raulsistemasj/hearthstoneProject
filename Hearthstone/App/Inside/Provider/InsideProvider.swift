//
//  InsideProvider.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

import Foundation

final class InsideProvider: RequestProvider {
    var httpMethod: HTTPMethod { .get }
    var body: [String : Any] { [:] }
    var endpoint: String { "cards/\(category)/\(name)" }
    
    let category: String
    let name: String
    
    init(category: String, name: String) {
        self.category = category
        self.name = name
    }
}
