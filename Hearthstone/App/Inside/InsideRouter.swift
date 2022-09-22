//
//  InsideRouter.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

@objc protocol InsideRoutingLogic {
    func routeToDismiss()
    func routeToError()
}

protocol InsideDataPassing {
    var dataStore: InsideDataStore? { get }
}

final class InsideRouter: NSObject, InsideRoutingLogic, InsideDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: InsideViewController?
    var dataStore: InsideDataStore?
    
    // MARK: - Routing Logic
    
    func routeToDismiss() {
        viewController?.dismiss(animated: true)
    }
    
    func routeToError() {
        guard let alert = viewController?.alert else { return }
        viewController?.present(alert, animated: true, completion: nil)
    }
    
}
