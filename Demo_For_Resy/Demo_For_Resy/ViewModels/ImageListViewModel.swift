//
//  ImageListViewModel.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/15/25.
//

import Foundation
 
class ImageListViewModel {
    //MARK: - Variables
    private var dataManager: Fetchable
    var isLoading = Observable<Bool>(false)
    var error = Observable<NetworkError?>(nil)
    var shouldReloadData = Observable<Bool>(false)
    #if FLAG_OPTIMIZATION
    var isScrolling = Observable<Bool>(false)
    #endif
    var imageListCellViewModels = Observable<[ImageListCellViewModel]>([])
    init(dataManager: Fetchable = DataManager()) {
        self.dataManager = dataManager
    }
    
    #if FLAG_OPTIMIZATION
    func updatedScrollingValue(isScrolling: Bool) {
        let _ = imageListCellViewModels.value.map{ model in
            model.isScrolling = isScrolling
        }
    }
    
    func setUpImageListCellViewModel(imageList: [ImageModel]) {
        imageListCellViewModels.value = imageList.map{ ImageListCellViewModel(model: $0, isScrolling: isScrolling.value) }
    }
    #else
    func setUpImageListCellViewModel(imageList: [ImageModel]) {
        imageListCellViewModels.value = imageList.map{ ImageListCellViewModel(model: $0) }
    }
    #endif
}

//MARK: - Set up data for tableview
extension ImageListViewModel {
    func numberOfRows() -> Int {
        return imageListCellViewModels.value.count
    }
    
    func cellModelData(with indexPath: IndexPath) -> ImageListCellViewModel {
        return imageListCellViewModels.value[indexPath.row]
    }
}

//MARK: - Networking
extension ImageListViewModel {
    func fetchImageList() {
        
        //Create request
        let request = ImageListRequest()
        
        //Send data to server
        isLoading.value = true
        dataManager.fetchData(with: request) { [weak self] (imageList: [ImageModel]?,
                                                error: NetworkError?) in
            self?.isLoading.value = false
            if let imageList = imageList {
                self?.setUpImageListCellViewModel(imageList: imageList)
            } else if let error = error {
                self?.error.value = error
            }
            self?.shouldReloadData.value = true
        }
    }
}
private struct ImageListRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .imageList
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}
