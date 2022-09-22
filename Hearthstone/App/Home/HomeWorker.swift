//
//  HomeWorker.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol HomeWorkerLogic {
    func fetchData(with provider: HomeProvider, completion: @escaping (Result<Home.Model.Response, APIError>) -> Void)
}

final class HomeWorker: HomeWorkerLogic {
    
    // MARK: - Objects
    
    let apiService: APIServiceProtocol
    
    // MARK: - LifeCycle
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    // MARK: - Worker Logic
    
    func fetchData(with provider: HomeProvider, completion: @escaping (Result<Home.Model.Response, APIError>) -> Void) {
        apiService.fetch(model: Home.Model.Response.self, request: provider, completion: completion)
    }
}
