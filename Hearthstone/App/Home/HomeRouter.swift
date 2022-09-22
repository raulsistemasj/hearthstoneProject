//
//  HomeRouter.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToInside()
    func routeToError()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: - Routing Logic
    
    func routeToInside() {
        let nextController = InsideViewController()
        nextController.modalPresentationStyle = .fullScreen
        var destinationDS = nextController.router?.dataStore
        passDataToInside(source: dataStore, destination: &destinationDS)
        viewController?.present(nextController, animated: true)
    }
    
    func routeToError(){
        guard let alert = viewController?.alert else { return }
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Passing data
    
    func passDataToInside(source: HomeDataStore?, destination: inout InsideDataStore?) {
        destination?.name = source?.name ?? ""
        destination?.category = source?.category ?? ""
    }
}
