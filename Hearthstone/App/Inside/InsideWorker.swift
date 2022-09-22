//
//  InsideWorker.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol InsideWorkerLogic {
    func fetchData(with provider: InsideProvider, completion: @escaping (Result<[Inside.Model.Response], APIError>) -> Void)
}

final class InsideWorker: InsideWorkerLogic {
    
    // MARK: - Objects
    
    let apiService: APIServiceProtocol
    
    // MARK: - LifeCycle
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    // MARK: - Worker Logic
    
    func fetchData(with provider: InsideProvider, completion: @escaping (Result<[Inside.Model.Response], APIError>) -> Void) {
        apiService.fetch(model: [Inside.Model.Response].self, request: provider, completion: completion)
    }
}
