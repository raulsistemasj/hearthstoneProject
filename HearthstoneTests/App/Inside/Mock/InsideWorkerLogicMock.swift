//
//  InsideWorkerLogicMock.swift
//  HearthstoneTests
//
//  Created by Raul M Ferreira on 22/09/22.
//

import Foundation

@testable import Hearthstone

class InsideWorkerLogicMock: InsideWorkerLogic {
    
    
    let isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func fetchData(with provider: Hearthstone.InsideProvider, completion: @escaping (Result<[Hearthstone.Inside.Model.Response], Hearthstone.APIError>) -> Void) {
        let response = Inside.Model.Response(img: "img")
        isSuccess ? completion(.success([response])) : completion(.failure(.mappingError))
    }

}
