//
//  ImageListViewModelTests.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/16/25.
//

import XCTest
@testable import Demo_For_Resy

final class ImageListViewModelTests: XCTestCase {
    //MARK: - Variables
    var sut: ImageListViewModel!
    var dataManager: MockDataManager<[ImageModel]>!
    
    //MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dataManager = MockDataManager()
        sut = ImageListViewModel(dataManager: dataManager)
    }
    
    //MARK: - Tear down
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //MARK: - Tests
    func testFetchFetchImageList() {
        //Given
        let emptyImageModel: [ImageModel] = []
        dataManager.model = emptyImageModel
        
        //When
        sut.fetchImageList()
        
        //Then
        XCTAssertTrue(dataManager.isDataFetched, "Data should be fetched")
    }
    
    func testFetchTracksFail() {
        
        //Given
        let error = NetworkError.noData
        
        //When
        sut.fetchImageList()
        dataManager.fetchWithError(error)
        
        //Then
        XCTAssertEqual(sut.error.value?.description, error.description,
                       "Both errors should be equal.")
    }
    
    func testSuccessfulFetchImageList() {
        
        //Given
        let imageLists: [ImageModel] = FileLoader.readDataFromFile(at: "image_list_data")
        dataManager.model = imageLists
        let expectation = XCTestExpectation(description: "Reload tableView triggered")
        sut.shouldReloadData.bind { success in
            if success { expectation.fulfill() }
        }

        //When
        sut.fetchImageList()
        dataManager.fetchWithSuccess()

        //Then
        XCTAssertTrue(imageLists.count > 0, "Image list data should be there.")
        let imageModel = imageLists[0]
        XCTAssertEqual(imageModel.id, 0, "image ids should be equal.")
        XCTAssertEqual(imageModel.filename, "0.jpeg", "image filename should be equal.")
        XCTAssertEqual(imageModel.width, 5000, "image width should be equal.")
        XCTAssertEqual(imageModel.height, 3333, "image height should be equal.")

        wait(for: [expectation], timeout: 1.0)
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
        sut.fetchImageList()
        
        //Assert
        XCTAssert(loading)
        
        //When finished fetching
        dataManager.fetchWithSuccess()
        
        //Assert
        XCTAssertFalse(loading)
        
        wait(for: [expectation], timeout: 1.0)
    }

}
