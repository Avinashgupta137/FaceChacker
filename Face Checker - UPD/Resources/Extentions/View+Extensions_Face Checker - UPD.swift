//
//  View+Extensions.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI

typealias view_FaceChecker_UPD = View

extension view_FaceChecker_UPD {
    func withoutAnimation_POPOPOVLAD(action: @escaping () -> Void) {
        
        // APP REF
        
        func random_FaceChecker_UPD() {
            let _ = "random_FaceChecker_UPD".map {
                $0.uppercased()
            }
        }
        
        //
        
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
}
