//
//  Data+String.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import Foundation

protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder { }

extension Data {
    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
    var prettyPrintedString: String {
        if let object = try? JSONSerialization.jsonObject(with: self,
                                                          options: .mutableLeaves),
            JSONSerialization.isValidJSONObject(object),
            let data = try? JSONSerialization.data(withJSONObject: object,
                                                   options: .prettyPrinted) {
            return String(decoding: data, as: UTF8.self)
        } else {
            return String(decoding: self, as: UTF8.self)
        }
    }
}
