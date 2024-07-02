//
//  SearchResponse.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import UIKit
import FaviconFinder

struct SearchResponse: Codable {
    var _code: String?
    var error: String?
    var searchId: String?
    var message: String?
    var progress: Int?
    var output: Output_POPOPOVLAD?
    
    var code: FaceCode {
        return FaceCode.fromServer(self._code)
    }
    
    enum CodingKeys: String, CodingKey {
        case _code = "code"
        case error
        case searchId = "id_search"
        case message
        case progress
        case output
    }
    
    struct Output_POPOPOVLAD: Codable {
        var items: [Item_POPOPOVLAD]
        
        struct Item_POPOPOVLAD: Codable, Hashable {
            var score: Int
            var group: Int
            var guid: String
            var base64: String
            var url: String
            
//            init(score: Int, base64: String) {
//                self.score = score
//                self.group = 0
//                self.guid = ""
//                self.base64 = base64
//                self.url = ItemUrl(value: "")
//            }
            
            var data: Data? {
                let split = base64.components(separatedBy: ",")
                if let piece = split.last {
                    if let data = Data(base64Encoded: piece, options: .ignoreUnknownCharacters) {
                        return data
                    }
                }
                return nil
            }
            
            struct ItemUrl: Codable, Hashable {
                var value: String
            }
        }
    }
}

struct SearchGroup: Hashable {
    var groupIndex: Int?
    var score: Int?
    var items: [SearchResponse.Output_POPOPOVLAD.Item_POPOPOVLAD]?
    
    var data: Data? {
        if let split = self.items?.first?.base64.components(separatedBy: ","),
           let piece = split.last
        {
            if let data = Data(base64Encoded: piece, options: .ignoreUnknownCharacters) {
                return data
            }
        }
        return nil
    }
    
    init(group: Dictionary<Int, [SearchResponse.Output_POPOPOVLAD.Item_POPOPOVLAD]>.Element) {
        if let firstItem = group.value.first {
            self.groupIndex = group.key
            self.score = firstItem.score
            self.items = group.value
        }
    }
}
