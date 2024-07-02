//
//  CheckViewController.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit

final class CheckViewController: UIViewController, ViewHostable_FaceChecker_UPD {
    
    // MARK: - Variables
    
    var image: UIImage
    
    // MARK: - Init
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.add_POPOPOVLAD(hostableView: CheckView(image: self.image))
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
