//
//  HomeBusinessLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone

class HomeBusinessLogicSpy: HomeBusinessLogic {
    
    var loadScreenValuesCalled = false
    var didSelectCalled = false
    
    func loadScreenValues() {
        loadScreenValuesCalled = true
    }
    
    func didSelect(category: String, name: String) {
        didSelectCalled = true
    }
    
}
