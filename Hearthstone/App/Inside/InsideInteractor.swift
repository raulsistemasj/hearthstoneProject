//
//  InsideInteractor.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol InsideBusinessLogic {
    func loadScreenValues()
}

protocol InsideDataStore {
    var name: String { get set }
    var category: String { get set }
}

final class InsideInteractor: InsideBusinessLogic, InsideDataStore {
    
    // MARK: - DataStore Objects
    
    var name: String = ""
    var category: String = ""
    
    // MARK: - Archtecture Objects
    
    var presenter: InsidePresentationLogic?
    let worker: InsideWorkerLogic
    
    // MARK: - Interactor Lifecycle
    
    init(worker: InsideWorkerLogic = InsideWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        let provider = InsideProvider(category: prepareParameter(category),
                                      name: prepareParameter(name))
        worker.fetchData(with: provider, completion: handleResponse)
    }
    
    private func prepareParameter(_ parameter: String) -> String {
        parameter.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    // MARK: - Handle Func
    
    private func handleResponse(_ result: (Result<[Inside.Model.Response], APIError>)) {
        switch result {
            case .success(let response):
                let imageList = response.compactMap({ $0.img })
                presenter?.presentScreenValues(category: category, imageList: imageList)
            case .failure(_ ):
                presenter?.presentError()
        }
    }
}
