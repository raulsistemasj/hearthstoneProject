//
//  InsideDisplayLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone

class InsideDisplayLogicSpy: InsideDisplayLogic {
    
    var displayScreenValuesCalled = false
    var displayErrorCalled = false
    
    func displayScreenValues(viewModel: Hearthstone.Inside.Model.ViewModel) {
        displayScreenValuesCalled = true
    }
    
    func displayError(_ viewModel: Hearthstone.Inside.Model.ErrorViewModel) {
        displayErrorCalled = true
    }

}
