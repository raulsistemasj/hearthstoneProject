//
//  HomePresentationLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone

class HomePresentationLogicSpy: HomePresentationLogic {
    
    var presentScreenValuesCalled = false
    var presentErrorCalled = false
    
    func presentScreenValues(with response: Hearthstone.Home.Model.Response) {
        presentScreenValuesCalled = true
    }
    
    func presentError() {
        presentErrorCalled = true
    }
    
}
