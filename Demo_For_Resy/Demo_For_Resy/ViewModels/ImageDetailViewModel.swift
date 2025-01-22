//
//  ImageDetailViewModel.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/15/25.
//

import Foundation

protocol ImageDetailViewModelInput {
    var imageID: Int { set get }
}

protocol ImageDetailViewModelOutput {
    var isLoading: Observable<Bool> { set get }
    var error: Observable<NetworkError?> { set get }
    var isLandscapeImage: Bool { get }
    var imageDetailModel: Observable<ImageDetailModel?> { set get }
    func fetchImageDetail()
}

typealias ImageDetailViewModel = ImageDetailViewModelInput & ImageDetailViewModelOutput

class DefaultImageDetailViewModel: ImageDetailViewModel {    
    //MARK: - Variables
    private var dataManager: Fetchable
    internal var imageID: Int
    var isLoading = Observable<Bool>(false)
    var error = Observable<NetworkError?>(nil)
    var imageDetailModel = Observable<ImageDetailModel?>(nil)
    var isLandscapeImage: Bool
    init(dataManager: Fetchable = DataManager(), imageID: Int, isLandscapeImage: Bool) {
        self.dataManager = dataManager
        self.imageID = imageID
        self.isLandscapeImage = isLandscapeImage
    }
}

//MARK: - Networking
extension DefaultImageDetailViewModel {
    func fetchImageDetail() {
        //Create request
        let request = ImageDetailRequest(imageID: imageID)
        
        //Send data to server
        isLoading.value = true
        dataManager.fetchData(with: request) { [weak self] (imageDetailModel: ImageDetailModel?,
                                                error: NetworkError?) in
            self?.isLoading.value = false
            if let imageDetailModel = imageDetailModel {
                self?.imageDetailModel.value = imageDetailModel
            } else if let error = error {
                self?.error.value = error
            }
        }
    }
}

private struct ImageDetailRequest: APIRequest {
    var imageID: Int
    var method: HTTPMethod = .GET
    var path: EndPoint {
        .imageInfo(imageID)
    }
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}
