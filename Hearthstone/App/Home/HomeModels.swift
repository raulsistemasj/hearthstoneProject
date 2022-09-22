//
//  HomeModels.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

enum Home {
    enum Model {
        struct Response: Codable {
            let classes: [String]
            let types: [String]
            let races: [String]
        }
        
        struct ViewModel {
            let title: String
            let classeOptions: HomeCardOptionsViewModel
            let typeOptions: HomeCardOptionsViewModel
            let raceOptions: HomeCardOptionsViewModel
        }
        
        struct HomeCardOptionsViewModel {
            let title: String
            let cards: [String]
        }
        
        struct ErrorViewModel{
            let title: String
            let message: String
            let retryButton: String
            let cancel: String
        }
    }
}
