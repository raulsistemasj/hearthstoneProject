//
//  HomePresenterTests.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone
import XCTest

class HomePresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: HomePresenter?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupHomePresenter() {
        sut = HomePresenter()
    }
    
    // MARK: - Tests
    
    func testPresentScreenValues() {
        //  Given
        let spy = HomeDisplayLogicSpy()
        sut?.viewController = spy
        _ = expectation(for: NSPredicate(value: true), evaluatedWith: spy.displayScreenValuesCalled, handler: nil)
        let response = Home.Model.Response(classes: [], types: [], races: [])

        // When
        sut?.presentScreenValues(with: response)

        // Then
        waitForExpectations(timeout: 2.0)
        XCTAssertTrue(spy.displayScreenValuesCalled)
    }
    
    func testPresentError() {
        
        //  Given
        let spy = HomeDisplayLogicSpy()
        sut?.viewController = spy

        // When
        sut?.presentError()

        // Then
        XCTAssertTrue(spy.displayErrorCalled)
        
    }
}
