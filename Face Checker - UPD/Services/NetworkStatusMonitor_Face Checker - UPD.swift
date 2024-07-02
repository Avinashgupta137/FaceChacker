//  Created by Systems
//

import Foundation
import Network
import UIKit

fileprivate let random = "random_FaceChecker_UPD".map {
    $0.uppercased()
}

protocol NetworkStatusMonitorDelegate_FaceChecker_UPD : AnyObject {
    func showMess_FaceChecker_UPD()
}

class NetworkStatusMonitor_FaceChecker_UPD {
    let random = "random_FaceChecker_UPD".map {
        $0.uppercased()
    }
    
    static let shared = NetworkStatusMonitor_FaceChecker_UPD()

    private let queue = DispatchQueue.global()
    private let nwMonitor: NWPathMonitor
    
    weak var delegate : NetworkStatusMonitorDelegate_FaceChecker_UPD?

    public private(set) var isNetworkAvailable: Bool = false {
        didSet {
            let _ = "random_FaceChecker_UPD".map {
                $0.uppercased()
            }
            if !isNetworkAvailable {
                DispatchQueue.main.async {
                    print("No internet connection.")
                    self.delegate?.showMess_FaceChecker_UPD()
                }
            } else {
                print("Internet connection is active.")
            }
        }
    }

    private init() {
      
        nwMonitor = NWPathMonitor()
    }

    func startMonitoring_FaceChecker_UPD() {
      
        nwMonitor.start(queue: queue)
        nwMonitor.pathUpdateHandler = { path in
            self.isNetworkAvailable = path.status == .satisfied
        }
    }

    func stopMonitoring_FaceChecker_UPD() {
      
        nwMonitor.cancel()
    }
}
