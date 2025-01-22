//
//  ImageDetailModelTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/15/25.
//

import XCTest
@testable import Demo_For_Resy

final class ImageDetailModelTests: XCTestCase {

    //MARK: - Variables
    var sut: ImageDetailModel!
        
    //MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = ImageDetailModel(id: "0", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/yC-Yzbqy7PY", download_url: "https://picsum.photos/id/0/5000/3333")
    }
    
    //MARK: - Teardown
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //MARK: - Tests
    func testSuccessImageDetailModel() {
        XCTAssertNotNil(sut, "ImageDetail object should be there.")
        XCTAssertNotNil(sut.id, "imageID should be there.")
        XCTAssertEqual(sut.id, "0", "Both imageID should be same.")
        XCTAssertNotNil(sut.author, "author should be there.")
        XCTAssertEqual(sut.author, "Alejandro Escamilla", "Both author should be same.")
        XCTAssertNotNil(sut.width, "image width should be there.")
        XCTAssertEqual(sut.width, 5000, "Both image width should be same.")
        XCTAssertNotNil(sut.height, "image height should be there.")
        XCTAssertEqual(sut.height, 3333, "Both image height should be same.")
        XCTAssertNotNil(sut.url, "url should be there.")
        XCTAssertEqual(sut.url, "https://unsplash.com/photos/yC-Yzbqy7PY", "Both url should be same.")
        XCTAssertNotNil(sut.download_url, "download_url should be there.")
        XCTAssertEqual(sut.download_url, "https://picsum.photos/id/0/5000/3333", "Both download_url should be same.")
        let duplicateSut = sut
        XCTAssertTrue(duplicateSut == sut, "Both ImageDetail object should be same")
    }
    
    func testFailureImageDetailModel() {
        XCTAssertNotNil(sut, "ImageDetail object should be there.")
        XCTAssertNotEqual(sut.id, "-1", "Both imageID should be same.")
        XCTAssertNotEqual(sut.author, "", "Both author should be same.")
        XCTAssertNotEqual(sut.width, 100, "Both image width should be same.")
        XCTAssertNotEqual(sut.height, 100, "Both image height should be same.")
        XCTAssertNotEqual(sut.url, "", "Both url should be same.")
        XCTAssertNotEqual(sut.download_url, "", "Both download_url should be same.")
        let duplicateSut = sut
        XCTAssertFalse(duplicateSut != sut, "Both ImageDetail object should be same")
    }
}
