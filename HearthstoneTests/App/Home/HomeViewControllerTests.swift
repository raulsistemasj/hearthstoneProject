//
//  HomeViewControllerTests.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

@testable import Hearthstone
import XCTest

class HomeViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: HomeViewController?
    var window: UIWindow?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupHomeViewController() {
        sut = HomeViewController()
    }
    
    func loadView() {
        guard let sut = sut else { return }
        window?.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    func testLoadScreenValues() {
        // Given
        let spy = HomeBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadScreenValuesCalled)
    }
    
    func testDisplayScreenValues() {
        
        // Given
        let classOptionVM = Home.Model.HomeCardOptionsViewModel(title: "title", cards: ["Sou um card"])
        let typeOptionVM = Home.Model.HomeCardOptionsViewModel(title: "title", cards: ["Sou um card"])
        let racesOptionVM = Home.Model.HomeCardOptionsViewModel(title: "title", cards: ["Sou um card"])
        
        let viewModel = Home.Model.ViewModel(title: "title", classeOptions: classOptionVM, typeOptions: typeOptionVM, raceOptions: racesOptionVM)
        
        // When
        loadView()
        sut?.displayScreenValues(viewModel: viewModel) 
        
        // Then
        XCTAssertEqual(sut?.titleLabel.text, viewModel.title)
        
    }
    
    func testDisplayError() {
        
        // Given
        let viewModel = Home.Model.ErrorViewModel(title: "Erro", message: "Message", retryButton: "erro", cancel: "Cancel")
        let spy = HomeRoutingLogicSpy()
        sut?.router = spy
        
        // When
        loadView()
        sut?.displayError(viewModel)
        
        // Then
        XCTAssertTrue(spy.routeToErrorCalled)
    }
}
