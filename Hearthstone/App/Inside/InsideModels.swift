//
//  InsideModels.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

enum Inside {
    enum Model {
        struct Response: Codable {
            let img: String?
        }
        struct ViewModel {
            let title: String
            let imageList: [String]
        }
        struct ErrorViewModel {
            let title: String
            let message: String
            let retryButton: String
            let cancel: String
        }
    }
}
