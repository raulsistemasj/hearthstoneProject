//
//  InsideViewControllerTests.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 22/09/22.
//

@testable import Hearthstone
import XCTest

class InsideViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: InsideViewController?
    var window: UIWindow?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupInsideViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupInsideViewController() {
        sut = InsideViewController()
    }
    
    func loadView() {
        guard let sut = sut else { return }
        window?.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    func testLoadScreenValues() {
        // Given
        let spy = InsideBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadScreenValuesCalled)
    }
    
    func testDisplayScreenValues() {
        // Given
        let viewModel = Inside.Model.ViewModel(title: "title", imageList: [])
        
        // When
        loadView()
        sut?.displayScreenValues(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut?.nameTypeLabel.text, viewModel.title)
    }
}
