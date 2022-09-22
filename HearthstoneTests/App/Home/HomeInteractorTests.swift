//
//  HomeInteractorTests.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone
import XCTest

class HomeInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: HomeInteractor?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupHomeInteractor() {
        sut = HomeInteractor()
    }
    
    // MARK: - Tests
    
    func testLoadScreenValuesSuccess() {
        // Given
        let workerMock = HomeWorkerLogicMock(isSuccess: true)
        sut = HomeInteractor(worker: workerMock)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadScreenValues()
        
        // Then
        XCTAssertTrue(spy.presentScreenValuesCalled)
    }
    
    func testLoadScreenValuesError() {
        // Given
        let workerMock = HomeWorkerLogicMock(isSuccess: false)
        sut = HomeInteractor(worker: workerMock)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadScreenValues()
        
        // Then
        XCTAssertTrue(spy.presentErrorCalled)
    }
    

    func testDidSelect() {
        // Given
        let name = "teste"
        let category = "category"
        
        // When
        sut?.didSelect(category: category, name: name)
        
        // Then
        XCTAssertEqual(sut?.category, category)
        XCTAssertEqual(sut?.name, name)
    }
}
