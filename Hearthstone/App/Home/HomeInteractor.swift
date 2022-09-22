//
//  HomeInteractor.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol HomeBusinessLogic {
    func loadScreenValues()
    func didSelect(category: String, name: String)
}

protocol HomeDataStore {
    var name: String { get set }
    var category: String { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {

    // MARK: - DataStore Objects
    
    var name: String = ""
    var category: String = ""
    
    // MARK: - Architecture Objects
    
    var presenter: HomePresentationLogic?
    let worker: HomeWorkerLogic
    
    // MARK: - Interactor Lifecycle
    
    init(worker: HomeWorkerLogic = HomeWorker()) {
        self.worker = worker
    }
        
    // MARK: - Business Logic
    
    func loadScreenValues() {
        let provider = HomeProvider()
        worker.fetchData(with: provider, completion: handleResponse)
    }
    
    func didSelect(category: String, name: String) {
        self.name = name
        self.category = category
    }
    
    // MARK: - Handle Func
    
    private func handleResponse(_ result: (Result<Home.Model.Response, APIError>)) {
        switch result {
            case .success(let response):
                presenter?.presentScreenValues(with: response)
            case .failure(_ ):
                presenter?.presentError()
                
        }
    }
}
