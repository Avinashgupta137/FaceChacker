//
//  SourcesViewController.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit

final class SourcesViewController_FaceChecker_UPD: UIViewController, ViewHostable_FaceChecker_UPD {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // APP REF
        
        func random_FaceChecker_UPD() {
            let _ = "random_FaceChecker_UPD".map {
                $0.uppercased()
            }
        }
        
        //
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    public func setup_POPOPOVLAD(image: UIImage, group: SearchGroup) {
        
        // APP REF
        
        func random_FaceChecker_UPD() {
            let _ = "random_FaceChecker_UPD".map {
                $0.uppercased()
            }
        }
        
        //
        
        self.add_POPOPOVLAD(hostableView: SourcesView(image: image, group: group))
    }
}
