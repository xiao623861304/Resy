//
//  ImageModelTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/15/25.
//

import XCTest
@testable import Demo_For_Resy

class ImageModelTests: XCTestCase {

    //MARK: - Variables
    var sut: ImageModel!
        
    //MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = ImageModel(format: "jpeg", width: 5000, height: 3333, filename: "0.jpeg", id: 0, author: "Alejandro Escamilla", author_url: "https://unsplash.com/photos/yC-Yzbqy7PY", post_url: "https://unsplash.com/photos/yC-Yzbqy7PY")
    }

    //MARK: - Teardown
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //MARK: - Tests
    func testSuccessImageDetailModel() {
        XCTAssertNotNil(sut, "Image object should be there.")
        XCTAssertNotNil(sut.id, "imageID should be there.")
        XCTAssertEqual(sut.id, 0, "Both imageID should be same.")
        XCTAssertNotNil(sut.author, "author should be there.")
        XCTAssertEqual(sut.author, "Alejandro Escamilla", "Both author should be same.")
        XCTAssertNotNil(sut.format, "format should be there.")
        XCTAssertEqual(sut.format, "jpeg", "Both format should be same.")
        XCTAssertNotNil(sut.filename, "filename should be there.")
        XCTAssertEqual(sut.filename, "0.jpeg", "Both filename should be same.")
        XCTAssertNotNil(sut.width, "image width should be there.")
        XCTAssertEqual(sut.width, 5000, "Both image width should be same.")
        XCTAssertNotNil(sut.height, "image height should be there.")
        XCTAssertEqual(sut.height, 3333, "Both image height should be same.")
        XCTAssertNotNil(sut.author_url, "author_url should be there.")
        XCTAssertEqual(sut.author_url, "https://unsplash.com/photos/yC-Yzbqy7PY", "Both author_url should be same.")
        XCTAssertNotNil(sut.post_url, "post_url should be there.")
        XCTAssertEqual(sut.post_url, "https://unsplash.com/photos/yC-Yzbqy7PY", "Both post_url should be same.")
        let duplicateSut = sut
        XCTAssertTrue(duplicateSut == sut, "Both ImageDetail object should be same")
    }
    
    func testFailureImageDetailModel() {
        XCTAssertNotNil(sut, "Image object should be there.")
        XCTAssertNotEqual(sut.id, -1, "Both imageID should be same.")
        XCTAssertNotEqual(sut.author, "", "Both author should be same.")
        XCTAssertNotEqual(sut.format, "", "Both format should be same.")
        XCTAssertNotEqual(sut.filename, "", "Both filename should be same.")
        XCTAssertNotEqual(sut.width, 100, "Both image width should be same.")
        XCTAssertNotEqual(sut.height, 100, "Both image height should be same.")
        XCTAssertNotEqual(sut.author_url, "", "Both author_url should be same.")
        XCTAssertNotEqual(sut.post_url, "", "Both post_url should be same.")
        let duplicateSut = sut
        XCTAssertFalse(duplicateSut != sut, "Both ImageDetail object should be same")
    }
}
