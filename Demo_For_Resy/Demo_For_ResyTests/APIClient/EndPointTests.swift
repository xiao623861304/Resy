//
//  EndPointTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/15/25.
//

import XCTest
@testable import Demo_For_Resy

class EndPointTests: XCTestCase {
    
    //MARK: - Variables
    var sut: EndPoint!
    
    //MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = EndPoint.baseURL
    }

    //MARK: - Teardown
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //MARK: - Tests
    func testSuccessfulError() {
        sut = EndPoint.baseURL
        XCTAssertNotNil(sut.rawValue, "Base URL should be there.")
        sut = EndPoint.imageList
        XCTAssertNotNil(sut.rawValue, "imageList should be there.")
        sut = EndPoint.imageInfo(0)
        XCTAssertNotNil(sut.rawValue, "imageInfo should be there.")
    }
    
    func testFailureError() {
        sut = EndPoint.baseURL
        XCTAssertNotEqual(sut.rawValue, "empty", "Base URL shouldn't be empty.")
        sut = EndPoint.imageList
        XCTAssertNotEqual(sut.rawValue, "empty", "imageList shouldn't be empty.")
        sut = EndPoint.imageInfo(0)
        XCTAssertNotEqual(sut.rawValue, "empty", "imageInfo shouldn't be empty.")

    }
}
