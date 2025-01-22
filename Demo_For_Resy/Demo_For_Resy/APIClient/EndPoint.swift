//
//  EndPoint.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import Foundation

/// `EndPoint` defines base URL, all paths and queries.
enum EndPoint: Hashable {
    //Base url
    case baseURL
    case imageList
    case imageInfo(Int)
}

extension EndPoint {
    var rawValue: String {
        switch self {
        //Base url
        case .baseURL:
            return "https://picsum.photos/"
        case .imageList:
            return "list"
        case .imageInfo(let imageId):
            return "id/\(imageId)/info"
        }
    }
}
