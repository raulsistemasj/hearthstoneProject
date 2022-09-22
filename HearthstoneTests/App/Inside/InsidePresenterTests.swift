//
//  InsidePresenterTests.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone
import XCTest

class InsidePresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: InsidePresenter?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupInsidePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupInsidePresenter() {
        sut = InsidePresenter()
    }
    
    // MARK: - Tests
    
    func testPresentScreenValues() {
        // Given
        let spy = InsideDisplayLogicSpy()
        sut?.viewController = spy
        
        _ = expectation(for: NSPredicate(value: true), evaluatedWith: spy.displayScreenValuesCalled, handler: nil)
                
        // When
        sut?.presentScreenValues(category: "classes", imageList: [])
        
        // Then
        waitForExpectations(timeout: 2.0)
        XCTAssertTrue(spy.displayScreenValuesCalled)
    }
}
