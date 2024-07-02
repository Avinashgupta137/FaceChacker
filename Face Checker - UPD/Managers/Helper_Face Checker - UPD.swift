//
//  Helper.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit

struct ScreenSize_FaceChecker_UPD {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize_FaceChecker_UPD.SCREEN_WIDTH, ScreenSize_FaceChecker_UPD.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize_FaceChecker_UPD.SCREEN_WIDTH, ScreenSize_FaceChecker_UPD.SCREEN_HEIGHT)
}

public struct Helper_FaceChecker_UPD {
    static var isPadPro: Bool {
        UIDevice.current.userInterfaceIdiom == .pad && ScreenSize_FaceChecker_UPD.SCREEN_MAX_LENGTH == 1366.0
    }
    
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
