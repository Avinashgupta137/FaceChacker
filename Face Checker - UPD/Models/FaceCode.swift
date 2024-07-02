//
//  FaceCode.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import Foundation

enum FaceCode {
    case undefined
    case queueBusy
    case imageError
    
    static func fromServer(_ rawValue: String?) -> Self {
        switch rawValue {
        case "QUEUE_BUSY":
            NetworkManager_FaceChecker_UPD.shared.invalidateTimer()
            return .queueBusy
        case "IMAGE_ERROR":
            NetworkManager_FaceChecker_UPD.shared.invalidateTimer()
            return .queueBusy
        default:
            return .undefined
        }
    }
    
    public func log_POPOPOVLAD() {
        if #available(iOS 15.0, *) {
            Log_FaceChecker_UPD.global.debug("\(Date().formatted(date: .omitted, time: .complete))\n🔬 Code: \(self.logMessage())")
        } else {
            Log_FaceChecker_UPD.global.debug("🔬 Code: \(self.logMessage())")
        }
    }
    
    public func log_POPOPOVLAD(message: String) {
        if #available(iOS 15.0, *) {
            Log_FaceChecker_UPD.global.debug("\(Date().formatted(date: .omitted, time: .complete))\n🔬 Code: \(message)")
        } else {
            Log_FaceChecker_UPD.global.debug("🔬 Code: \(message)")
        }
    }
    
    private func logMessage() -> String {
        switch self {
        case .undefined:
            return "Undefined."
        case .queueBusy:
            return "Queue is busy, aborting request."
        case .imageError:
            return "Image error."
        }
    }
}
