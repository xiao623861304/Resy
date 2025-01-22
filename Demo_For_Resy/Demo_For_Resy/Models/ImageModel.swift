//
//  ImageModel.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/15/25.
//

import Foundation

struct ImageModel: Codable, Equatable {
    let format: String?
    let width: Int?
    let height: Int?
    let filename: String?
    let id: Int?
    let author: String?
    let author_url: String?
    let post_url: String?
}
