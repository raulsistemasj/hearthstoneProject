//
//  HomeWorkerLogicMock.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone

class HomeWorkerLogicMock: HomeWorkerLogic {
    
    let isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func fetchData(with provider: Hearthstone.HomeProvider, completion: @escaping (Result<Hearthstone.Home.Model.Response, Hearthstone.APIError>) -> Void) {
        let response = Home.Model.Response(classes: [], types: [], races: [])
        isSuccess ? completion(.success(response)) : completion(.failure(.mappingError))
    }

}
