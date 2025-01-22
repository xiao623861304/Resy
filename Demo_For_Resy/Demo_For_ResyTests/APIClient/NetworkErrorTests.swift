//
//  NetworkErrorTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/15/25.
//

import XCTest
@testable import Demo_For_Resy

class NetworkErrorTests: XCTestCase {
    
    //MARK: - Variables
    private var sut: NetworkError!
    
    //MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = NetworkError.request
    }
    
    //MARK: - Tear down
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //MARK: - Tests
    func testSuccessfulError() {
        sut = NetworkError.request
        XCTAssertNotNil(sut.description, "Request error should be there.")
        sut = NetworkError.server
        XCTAssertNotNil(sut.description, "Server error should be there.")
        let url = URL(string: "https://www.domain.com")!
        sut = NetworkError.invalidURL(url)
        XCTAssertNotNil(sut.description, "URL invalid message should be there.")
        sut = NetworkError.noData
        XCTAssertNotNil(sut.description, "No data message should be there.")
        sut = NetworkError.jsonParse
        XCTAssertNotNil(sut.description, "JSON parsing message should be there.")
        sut = NetworkError.genericError("Error")
        XCTAssertNotNil(sut.description, "Generic error message should be there.")
    }
    
    func testFailureError() {
        sut = NetworkError.request
        XCTAssertNotEqual(sut.description, "empty", "Request error shouldn't be empty.")
        sut = NetworkError.server
        XCTAssertNotEqual(sut.description, "empty", "Server error shouldn't be empty.")
        let url = URL(string: "https://www.domain.com")!
        sut = NetworkError.invalidURL(url)
        XCTAssertNotEqual(sut.description, "empty", "URL invalid message shouldn't be empty.")
        sut = NetworkError.noData
        XCTAssertNotEqual(sut.description, "empty", "No data message shouldn't be empty.")
        sut = NetworkError.jsonParse
        XCTAssertNotEqual(sut.description, "empty", "JSON parsing message shouldn't be empty.")
        sut = NetworkError.genericError("Error")
        XCTAssertNotEqual(sut.description, "empty", "Generic error message shouldn't be empty.")
    }
}
