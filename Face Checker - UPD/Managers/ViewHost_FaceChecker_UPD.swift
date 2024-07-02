//
//  ViewHost.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI

struct ViewHost_FaceChecker_UPD {
    static func uiView(from view: some View) -> (UIViewController, UIView) {
        let hostingController = UIHostingController(rootView: view)
        let uiView = hostingController.view!
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return (hostingController, uiView)
    }
}

protocol ViewHostable_FaceChecker_UPD {
    func add_POPOPOVLAD(hostableView: some View)
}

extension ViewHostable_FaceChecker_UPD where Self: UIViewController {
    func add_POPOPOVLAD(hostableView: some View) {
        let (hostingController, uiView) = ViewHost_FaceChecker_UPD.uiView(from: hostableView)
        self.addChild(hostingController)
        self.view.addSubview(uiView)
        
        NSLayoutConstraint.activate([
            uiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            uiView.topAnchor.constraint(equalTo: self.view.topAnchor),
            uiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        hostingController.didMove(toParent: self)
    }
}
