//
//  ImageResponse.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import Foundation

struct ImageResponse: Codable {
    var success: Bool
    var status: Int
    var data: ImageData_POPOPOVLAD
    
    struct ImageData_POPOPOVLAD: Codable {
        var image: ImageResult
        
        struct ImageResult: Codable {
            var name: String
            var url: String
        }
    }
}
