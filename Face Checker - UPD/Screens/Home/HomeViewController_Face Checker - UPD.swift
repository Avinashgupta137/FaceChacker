//
//  HomeViewController_FaceChecker_UPD.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit
import SwiftUI
import Network

final class HomeViewController_FaceChecker_UPD: UIViewController, ViewHostable_FaceChecker_UPD {
    private let monitor = NWPathMonitor()
    private var splashView: UIHostingController<SplashView>?
    private var noInternetView: UIHostingController<NoInternetView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        showSplashScreen()
    }
    
    private func showSplashScreen() {
        let splashView = UIHostingController(rootView: SplashView())
        splashView.view.frame = self.view.bounds
        self.view.addSubview(splashView.view)
        self.addChild(splashView)
        self.splashView = splashView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.checkInternetConnection()
        }
    }
    
    private func checkInternetConnection() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.transitionToHomeView()
                   // self.showNoInternetView()
                } else {
                    self.showNoInternetView()
                }
            }
        }
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
    
    private func transitionToHomeView() {
        self.splashView?.willMove(toParent: nil)
        self.splashView?.view.removeFromSuperview()
        self.splashView?.removeFromParent()
        self.splashView = nil
        
        self.add_POPOPOVLAD(hostableView: Face_Picker_Controller())
    }
    
    private func showNoInternetView() {
        self.splashView?.willMove(toParent: nil)
        self.splashView?.view.removeFromSuperview()
        self.splashView?.removeFromParent()
        self.splashView = nil
        
        let noInternetView = UIHostingController(rootView: NoInternetView(retryAction: {
            self.checkInternetConnection()
        }))
        noInternetView.view.frame = self.view.bounds
        self.view.addSubview(noInternetView.view)
        self.addChild(noInternetView)
        self.noInternetView = noInternetView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
