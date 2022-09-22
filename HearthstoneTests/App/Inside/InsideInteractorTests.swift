//
//  InsideInteractorTests.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone
import XCTest

class InsideInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: InsideInteractor?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupInsideInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupInsideInteractor() {
        sut = InsideInteractor()
    }
    
    // MARK: - Tests
    
    func testLoadScreenValuesSuccess() {
        // Given
        let workerMock = InsideWorkerLogicMock(isSuccess: true)
        sut = InsideInteractor(worker: workerMock)
        let spy = InsidePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadScreenValues()
        
        // Then
        XCTAssertTrue(spy.presentScreenValuesCalled)
    }
}
