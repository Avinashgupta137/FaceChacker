//
//  Logger.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import OSLog

final class Log_FaceChecker_UPD {
    static let global = Logger.global
    
    static func info_FaceChecker_UPD(_ message: String) {
        Logger.global.info("\(message)")
    }
}

typealias logger_FaceChecker_UPD = Logger

extension logger_FaceChecker_UPD {
    enum Category_FaceChecker_UPD: String {
        case global = "global"
    }
    
    private static var subsystem = "FaceChecker_UPDLog"

    static let global = Logger(subsystem: subsystem, category: Category_FaceChecker_UPD.global.rawValue)
}
