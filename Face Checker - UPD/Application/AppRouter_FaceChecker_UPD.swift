//
//  AppRouter.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit
import Alamofire

final class AppRouter_FaceChecker_UPD {
    
    enum Destination {
        case custom(UIViewController)
        
        case home
        case browse(type: BrowseType)
        case check(image: UIImage)
        case results(image: UIImage)
        case sources(image: UIImage, group: SearchGroup)
    }
    
    enum TransitionType {
        case change
        case push(animated: Bool)
        case present(animated: Bool)
    }
    
    // MARK: - Static
    
    static let shared = AppRouter_FaceChecker_UPD()
    
    // MARK: - Variables
    
    public let navigationController = UINavigationController()
    
    private var internetConnectionAlert: UIAlertController {
        let alert = UIAlertController(
            title: nil,
            message: "Please, restore your internet connection for better experience.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    private var currentControllerName: String?
    
    // MARK: - Init
    
    private init() {
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.isNavigationBarHidden = true
        
        let blankController = UIViewController()
        blankController.view.backgroundColor = UIColor(named: "background")
        self.move(to: .custom(blankController), type: .change)
        
        self.checkConnection()
        
        self.move(to: .home, type: .change)
        //self.move(to: .check(image: UIImage()), type: .change)
        
    }
    
    // MARK: - Methods
    
    func initialViewController() -> UIViewController {
        
        return HomeViewController_FaceChecker_UPD()
    }
    
    public func checkConnection() {
        AF.request("https://www.google.com/").response { response in
            if response.data == nil {
                self.presentConnectionAlert()
            }
        }
    }
    
    func presentConnectionAlert() {
        DispatchQueue.main.async {
            AppRouter_FaceChecker_UPD.shared.move(
                to: .custom(self.internetConnectionAlert),
                type: .present(animated: true)
            )
        }
    }
    
    func back() {
        DispatchQueue.main.async {
            if self.currentControllerName == self.controllerName(ResultsViewController.self) {
                self.move(to: .home, type: .change)
            } else {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func move(to destination: AppRouter_FaceChecker_UPD.Destination, type: AppRouter_FaceChecker_UPD.TransitionType) {
        var viewController: UIViewController? {
            switch destination {
            case .custom(let viewController):
                return viewController
                
            case .home:
                return HomeViewController_FaceChecker_UPD()
                
            case .browse(let type):
                return BrowseViewController_FaceChecker_UPD(type: type)
                
            case .check(let image):
                return CheckViewController(image: image)
                
            case .results(let image):
                let viewController = ResultsViewController()
                viewController.setup_POPOPOVLAD(image: image)
                return viewController
                
            case .sources(let image, let group):
                let viewController = SourcesViewController_FaceChecker_UPD()
                viewController.setup_POPOPOVLAD(image: image, group: group)
                return viewController
                
            }
        
        }
        
        self.currentControllerName = self.controllerName(viewController)
        
        DispatchQueue.main.async {
            if let viewController {
                switch type {
                case .change:
                    self.navigationController.setViewControllers([viewController], animated: false)
                case .push(let animated):
                    self.navigationController.pushViewController(viewController, animated: animated)
                case .present(let animated):
                    self.navigationController.present(viewController, animated: animated)
                }
            }
        }
    }
    
    public func setCurrentController(_ controller: UIViewController) {
        if let subsequence = String(describing: controller).split(separator: ":").first,
           let result = subsequence.split(separator: "<").last
        {
            self.currentControllerName = String(result)
        }
    }
    
    public func setCurrentController(_ controllerType: UIViewController.Type) {
        self.currentControllerName = "FaceChecker_UPD." + String(describing: controllerType)
    }
    
    private func controllerName(_ controller: UIViewController?) -> String? {
        if let subsequence = String(describing: controller).split(separator: ":").first,
           let result = subsequence.split(separator: "<").last
        {
            return String(result)
        } else {
            return nil
        }
    }
    
    private func controllerName(_ controllerType: UIViewController.Type) -> String? {
        return "FaceChecker_UPD." + String(describing: controllerType)
    }
}
