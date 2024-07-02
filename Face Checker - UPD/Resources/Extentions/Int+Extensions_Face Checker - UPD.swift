//
//  Int+Extensions.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import Foundation

typealias int_FaceChecker_UPD = Int

extension int_FaceChecker_UPD {
    static func parse_POPOPOVLAD(_ string: String) -> Int? {
        Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
