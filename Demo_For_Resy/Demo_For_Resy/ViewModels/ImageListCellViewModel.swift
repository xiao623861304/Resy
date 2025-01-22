//
//  ImageListCellViewModel.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/19/25.
//

import Foundation

class ImageListCellViewModel {
    private let model: ImageModel
    #if FLAG_OPTIMIZATION
    var isScrolling: Bool
    init(model: ImageModel, isScrolling: Bool) {
        self.model = model
        self.isScrolling = isScrolling
    }
    #else
    init(model: ImageModel) {
        self.model = model
    }
    #endif
    
    func getImageUrl() -> URL? {
        if let modelID = model.id, let width = model.width, let height = model.height {
            let imageURLString = "\(EndPoint.baseURL.rawValue)id/\(modelID)/\(width)/\(height)"
            return URL(string: imageURLString)
        }
        return nil
    }
    
    func getFileName() -> String? {
        return model.filename
    }
    
    func getImageID() -> Int {
        return model.id ?? -1
    }
    
    func getImageDetail() -> String? {
        let imageShape = isLandscapeImage() ? "LandscapeImage" : "PortraitImage"
        if let width = model.width, let height = model.height {
            return "Width: \(width)  Height: \(height)\nImageShape: \(imageShape)"
        }
        return ""
    }
    
    func isLandscapeImage() -> Bool {
        if let width = model.width, let height = model.height {
            return width >= height
        }
        return true
    }
}
