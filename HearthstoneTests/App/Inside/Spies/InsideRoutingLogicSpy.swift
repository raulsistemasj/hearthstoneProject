//
//  InsideRoutingLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone

class InsideRoutingLogicSpy: InsideRoutingLogic, InsideDataPassing  {
    

    var dataStore: InsideDataStore?
    var routeToDismissCalled = false
    var routeToErrorCalled = false
    
    func routeToDismiss() {
        routeToDismissCalled = true
    }
    
    func routeToError() {
        routeToErrorCalled = true
    }
}
