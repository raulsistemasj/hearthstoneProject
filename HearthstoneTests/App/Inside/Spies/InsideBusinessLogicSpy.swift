//
//  InsideBusinessLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone

class InsideBusinessLogicSpy: InsideBusinessLogic {
    
    var loadScreenValuesCalled = false
    
    func loadScreenValues() {
        loadScreenValuesCalled = true
    }

}
