//
//  HomeDisplayLogicSpy.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone

class HomeDisplayLogicSpy: HomeDisplayLogic {
    
    var displayScreenValuesCalled = false
    var displayErrorCalled = false
    
    func displayScreenValues(viewModel: Hearthstone.Home.Model.ViewModel) {
        displayScreenValuesCalled = true
    }
    
    func displayError(_ viewModel: Hearthstone.Home.Model.ErrorViewModel) {
        displayErrorCalled = true
    }
    
}
