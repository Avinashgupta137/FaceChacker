//
//  Endpoint.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import Foundation

enum Endpoint: String {
    case upload = "upload_pic"
    case info = "info"
    case search = "search"
    
    static let base = "http://167.172.105.4:8080/bridge/facecheck/api/"
    
    func link() -> String {
        return Self.base + self.rawValue
    }
}
