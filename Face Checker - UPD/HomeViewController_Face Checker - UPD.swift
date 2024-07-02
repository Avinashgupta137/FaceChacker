//
//  HomeViewController_FaceChecker_UPD.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit

final class HomeViewController_FaceChecker_UPD: UIViewController, ViewHostable_FaceChecker_UPD {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.add_POPOPOVLAD(hostableView: HomeView_FaceChecker_UPD())
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
}
