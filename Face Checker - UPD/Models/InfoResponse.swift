//
//  InfoResponse.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import Foundation

struct InfoResponse: Codable {
    var faces: Int
    var isOnline: Bool
    
    enum CodingKeys: String, CodingKey {
        case faces
        case isOnline = "is_online"
    }
}
