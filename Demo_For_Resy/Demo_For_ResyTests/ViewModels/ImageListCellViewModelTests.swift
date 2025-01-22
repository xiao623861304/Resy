//
//  ImageListCellViewModelTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/17/25.
//

import XCTest
@testable import Demo_For_Resy
final class ImageListCellViewModelTests: XCTestCase {
    var sut: ImageListCellViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let model: ImageModel = FileLoader.readDataFromFile(at: "landscape_image_data")
        #if FLAG_OPTIMIZATION
        sut = ImageListCellViewModel(model: model, isScrolling: false)
        #else
        sut = ImageListCellViewModel(model: model)
        #endif
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testGetImageUrl() {
        let imageUrl = sut.getImageUrl()
        XCTAssertEqual(imageUrl, URL(string: "https://picsum.photos/id/0/5000/3333"), "imageURL should be equal.")
    }

    func testGetFileName() {
        let fileName = sut.getFileName()
        XCTAssertEqual(fileName, "0.jpeg", "file name should be equal.")
    }

    func testGetImageID() {
        let imageID = sut.getImageID()
        XCTAssertEqual(imageID, 0, "imageID should be equal.")
    }

    func testGetImageDetail() {
        let imageDetailInfo = sut.getImageDetail()
        XCTAssertEqual(imageDetailInfo, "Width: 5000  Height: 3333\nImageShape: LandscapeImage", "image detail information should be equal.")
    }
    
    func testIsLandscapeImage() {
        let isLandscape = sut.isLandscapeImage()
        XCTAssertTrue(isLandscape, "This is a landscape image")
    }
    
    func testIsPortraitImage() {
        let model: ImageModel = FileLoader.readDataFromFile(at: "portrait_image_data")
        #if FLAG_OPTIMIZATION
        sut = ImageListCellViewModel(model: model, isScrolling: false)
        #else
        sut = ImageListCellViewModel(model: model)
        #endif
        let isLandscape = sut.isLandscapeImage()
        XCTAssertFalse(isLandscape, "This is a portrait image")
    }

}
