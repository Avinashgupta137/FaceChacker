//
//  FaceMessage.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import Foundation

enum FaceMessage {
    case undefined
    case queue(place: Int)
    case searchCompleted
    
    static func fromServer(_ rawValue: String?) -> Self {
        guard let rawValue else { return .undefined }
        
        if rawValue.hasPrefix("Waiting in queue") {
            if let place = Int.parse_POPOPOVLAD(rawValue) {
                return .queue(place: place)
            }
        }
        
        switch rawValue {
        case "Search Completed":
            return .searchCompleted
        default:
            return .undefined
        }
    }
    
    public func log() {
        if #available(iOS 15.0, *) {
            Log_FaceChecker_UPD.global.debug("\(Date().formatted(date: .omitted, time: .complete))\n✉️ Message: \(self.logMessage())")
        } else {
            Log_FaceChecker_UPD.global.debug("✉️ Message: \(self.logMessage())")
        }
    }
    
    public func log(message: String) {
        if #available(iOS 15.0, *) {
            Log_FaceChecker_UPD.global.debug("\(Date().formatted(date: .omitted, time: .complete))\n✉️ Message: \(message)")
        } else {
            Log_FaceChecker_UPD.global.debug("✉️ Message: \(message)")
        }
    }
    
    private func logMessage() -> String {
        switch self {
        case .undefined:
            return "Undefined."
        case .queue(let place):
            return "In queue, \(place) place."
        case .searchCompleted:
            return "Search completed."
        }
    }
}
