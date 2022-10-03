///
//  SingKingTechnicalTaskTests.swift
//  SingKingTechnicalTaskTests
//
//  Created by Abdalah on 03/10/2022.
//


import XCTest
@testable import SingKingTechnicalTask

class APIServiceTests: XCTestCase {
    var sut: ApiService!
    var apiServiceMock: APIServiceMock!
    
    override func setUp() {
        super.setUp()
        sut = ApiService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    // testing News
    func test_get_New_List() {
        // Given
        let promise = XCTestExpectation(description: "Fetch News")
        var responseError: Error?
        var responseCharactersList: [CharactersNameInfo]?
        
        // When
        guard let bundle = Bundle.unitTest.path(forResource: "charactersList", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.fetchAllCharactersList(from: URL(fileURLWithPath: bundle)) { result in
            switch result {
            case .success(let response):
                responseCharactersList = response
                promise.fulfill()
            case .failure(let error):
                responseError = error
                promise.fulfill()
            }
        }
    
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseCharactersList)
    }
}
