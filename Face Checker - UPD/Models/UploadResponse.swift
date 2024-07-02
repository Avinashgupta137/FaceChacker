//
//  UploadResponse.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import Foundation

struct UploadResponse: Codable {
    var searchId: String
    var message: String
    var error: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case searchId = "id_search"
        case message
        case error
        case code
    }
}
