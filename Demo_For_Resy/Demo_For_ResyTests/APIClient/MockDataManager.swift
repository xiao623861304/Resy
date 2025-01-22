//
//  MockDataManager.swift
//  Demo_For_ResyTests
//
//  Created by yan feng on 1/15/25.
//

import XCTest
@testable import Demo_For_Resy

class MockDataManager<U: Codable>: Fetchable {
    
    //MARK: - Variables
    var handler: ((U?, NetworkError?) -> ())!
    var isDataFetched = false
    var model: U? = nil
    var models: [U] = []
    
    //MARK: - Success
    func fetchWithSuccess() {
        handler(model, nil)
    }
    
    //MARK: - Failure
    func fetchWithError(_ error: NetworkError?) {
        handler(nil, error)
    }
    
    //MARK: - API
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ()) {
        isDataFetched = true
        self.handler = { (data: U?, error: NetworkError?) in
            handler(data as? T, error)
        }
    }
}

