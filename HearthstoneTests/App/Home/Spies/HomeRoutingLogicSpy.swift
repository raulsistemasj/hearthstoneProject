//
//  HomeRoutingLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone
import UIKit

class HomeRoutingLogicSpy: NSObject, HomeRoutingLogic, HomeDataPassing  {
   
    var dataStore: HomeDataStore?
    var routeToInsideCalled = false
    var routeToErrorCalled = false
    
    func routeToInside() {
        routeToInsideCalled = true
    }
    
    func routeToError() {
        routeToErrorCalled = true
    }
}
