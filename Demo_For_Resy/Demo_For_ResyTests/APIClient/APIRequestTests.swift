//
//  APIRequestTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/15/25.
//

import XCTest
@testable import Demo_For_Resy

class APIRequestTests: XCTestCase {

    //MARK: - Variables
    var sut: APIRequest!
    
    //MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = MockRequest()
    }

    //MARK: - Teardown
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //MARK: - Tests
    func testSuccessfulRequest() {
        let request = sut.request()
        XCTAssertNotNil(request.httpMethod, "HTTP Method should be there.")
        XCTAssertEqual(request.httpMethod, HTTPMethod.GET.rawValue, "HTTP Methods should be same.")
        XCTAssertNotNil(request.url, "URL should be there.")
        XCTAssertEqual(request.url?.absoluteString, "https://picsum.photos/list?", "URL should be there.")
        XCTAssertNil(request.httpBody, "There is no body for the request.")
        XCTAssertNotNil(request.allHTTPHeaderFields, "Header Fields should be there.")
    }
    
    func testFailureRequest() {
        let request = sut.request()
        XCTAssertNotEqual(request.httpMethod, "empty","HTTP Method shouldn't be empty.")
        XCTAssertNotEqual(request.url?.absoluteString, "empty", "URL shouldn't be empty.")
        XCTAssertNotEqual(request.httpBody, Data(), "Data should be empty")
        XCTAssertNotEqual(request.allHTTPHeaderFields, [:], "Header Fields should not be empty.")
    }
}

struct MockRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .imageList
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}

struct Model: Codable {}
