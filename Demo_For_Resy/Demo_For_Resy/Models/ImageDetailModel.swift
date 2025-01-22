//
//  ImageDetailModel.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/15/25.
//

import Foundation

struct ImageDetailModel: Codable, Equatable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
