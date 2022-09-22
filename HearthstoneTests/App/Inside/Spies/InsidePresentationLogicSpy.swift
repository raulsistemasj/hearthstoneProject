//
//  InsidePresentationLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone

class InsidePresentationLogicSpy: InsidePresentationLogic {
        
    var presentScreenValuesCalled = false
    var presentErrorCalled = false
    
    func presentScreenValues(category: String, imageList: [String]) {
        presentScreenValuesCalled = true
    }
    
    func presentError() {
        presentErrorCalled = true
    }

}
