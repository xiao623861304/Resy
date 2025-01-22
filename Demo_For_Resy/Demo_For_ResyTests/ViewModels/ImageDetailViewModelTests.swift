//
//  ImageDetailViewModelTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/16/25.
//

import XCTest
@testable import Demo_For_Resy

class ImageDetailViewModelTests: XCTestCase {
    
    var sut: DefaultImageDetailViewModel!
    var dataManager: MockDataManager<ImageDetailModel>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dataManager = MockDataManager()
        sut = DefaultImageDetailViewModel(dataManager: dataManager, imageID: 0, isLandscapeImage: false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testFetchFetchImageDetail() {
        //Given
        let emptyImageModel = ImageDetailModel(id: nil, author: nil, width: nil, height: nil, url: nil, download_url: nil)
        dataManager.model = emptyImageModel
        
        //When
        sut.fetchImageDetail()
        
        //Then
        XCTAssertTrue(dataManager.isDataFetched, "Data should be fetched")
    }
    
    func testFetchTracksFail() {
        
        //Given
        let error = NetworkError.noData
        
        //When
        sut.fetchImageDetail()
        dataManager.fetchWithError(error)
        
        //Then
        XCTAssertEqual(sut.error.value?.description, error.description,
                       "Both errors should be equal.")
    }

    func testSuccessfulFetchImageDetail() {

        //Given
        let imageDetail: ImageDetailModel = FileLoader.readDataFromFile(at: "image_detail_data")
        dataManager.model = imageDetail

        //When
        sut.fetchImageDetail()
        dataManager.fetchWithSuccess()

        //Then
        XCTAssertEqual(imageDetail.id, "0", "image ids should be equal.")
        XCTAssertEqual(imageDetail.author, "Alejandro Escamilla", "image author should be equal.")
        XCTAssertEqual(imageDetail.width, 5000, "image width should be equal.")
        XCTAssertEqual(imageDetail.height, 3333, "image height should be equal.")

    }

    func testLoadingStatusWhileFetching() {

        //Given
        var loading = false
        let expectation = XCTestExpectation(description: "Loading status updated")
        sut.isLoading.bind { (success) in
            loading = success
            expectation.fulfill()
        }

        //When
        sut.fetchImageDetail()

        //Assert
        XCTAssert(loading)

        //When finished fetching
        dataManager.fetchWithSuccess()

        //Assert
        XCTAssertFalse(loading)

        wait(for: [expectation], timeout: 1.0)
    }
}
