//
//  NetworkManager_FaceChecker_UPD.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit
import Combine
import Alamofire

fileprivate let popovlad = "random_FaceChecker_UPD".map {
    $0.uppercased()
}

final class NetworkManager_FaceChecker_UPD: ObservableObject {
    
    // MARK: - Variables
    
    @Published var shouldShowImageError = false
    @Published var shouldShowAlert = false
    @Published var isLoading = false
    @Published var didUploadPhoto = false
    @Published var didStartSearch = false
    @Published var searchCompleted = false
    @Published var queuePlace: Int?
    @Published var progress: Int = 0
    
    var code: FaceCode? = nil {
        didSet {
            guard let code else { return }
            
            code.log_POPOPOVLAD()
            
            switch code {
            case .undefined:
                return
            case .queueBusy:
                DispatchQueue.main.async {
                    self.shouldShowAlert = true
                }
            case .imageError:
                DispatchQueue.main.async {
                    self.shouldShowImageError = true
                }
            }
        }
    }
    
    var message: FaceMessage? = nil {
        didSet {
            guard let message else { return }
            
            message.log()
            
            switch message {
            case .undefined:
                return
                
            case .queue(let place):
                self.queuePlace = place
                if place <= 2 {
                    if self.timer?.timeInterval == 2.0 { return }
                    let newInterval = 2.0
                    self.message?.log(message: "Setting new interval to \(newInterval).")
                    self.invalidateTimer()
                    self.timer = Timer(timeInterval: newInterval, repeats: true) { _ in
                        self.currentAction?()
                    }
                    self.startTimer(shouldFire: false)
                } else {
                    if self.timer?.timeInterval == 10.0 { return }
                    let newInterval = 10.0
                    self.message?.log(message: "Setting new interval to \(newInterval).")
                    self.invalidateTimer()
                    self.timer = Timer(timeInterval: newInterval, repeats: true) { _ in
                        self.currentAction?()
                    }
                    self.startTimer(shouldFire: false)
                }
                
            case .searchCompleted:
                self.searchCompleted = true
                self.message?.log(message: "Search completed, stopping timer.")
                self.resetState()
            }
        }
    }
    
    private(set) public var searchOutput: [SearchGroup]? {
        didSet {
            guard let searchOutput else { return }
            Log_FaceChecker_UPD.global.debug("Search output: \(searchOutput.count)")
        }
    }
    
    private var photoId: String = ""
    
    private(set) public var timer: Timer?
    private var currentAction: (() -> Void)? = nil
    
    // MARK: - Init
    
    static let shared = NetworkManager_FaceChecker_UPD()
    
    private init() { }
    
    // MARK: - Methods
    
    func isInternetConnected(completion: @escaping () -> Void) {
        AF.request("https://www.google.com/").response { response in
            if response.data == nil {
                AppRouter_FaceChecker_UPD.shared.presentConnectionAlert()
            } else {
                completion()
            }
        }
    }
    
    func startTimer(shouldFire: Bool) {
        if let timer {
            if shouldFire {
                timer.fire()
            }
            
            RunLoop.main.add(
                timer,
                forMode: .common
            )
        }
    }
    
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func resetState() {
        self.shouldShowImageError = false
        self.shouldShowAlert = false
        self.isLoading = false
        self.didUploadPhoto = false
        self.didStartSearch = false
        self.progress = 0
        self.queuePlace = nil
        self.invalidateTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .seconds(1))) {
            self.searchCompleted = false
        }
    }
    
    func upload(photo: UIImage) {
        guard let data = photo.jpegData(compressionQuality: 0.7) else { return }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AF.upload(
            multipartFormData: {
                $0.append(data, withName: "images", fileName: "photo.jpg", mimeType: "image/jpg")
            },
            to: Endpoint.upload.link(),
            method: .post,
            headers: [
                "Content-Type": "multipart/form-data"
            ]
        ).response {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            switch $0.result {
            case .success(let data):
                if let data {
                    let json = try? JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                    )
                    Log_FaceChecker_UPD.global.info("upload(photo)\n\(json.debugDescription)")
                    let jsonDictionary = json as? [String: Any]
                    if let code = jsonDictionary?["code"] as? String {
                        self.code = FaceCode.fromServer(code)
                    }
                    if let searchId = jsonDictionary?["id_search"] as? String {
                        self.search(searchId: searchId)
                    }
                }
            case .failure:
                return
            }
        }
    }
    
    func search(searchId: String) {
        Log_FaceChecker_UPD.global.info("search(searchId) = \(searchId)")
        
        self.didStartSearch = true
        
        let parameters: Parameters = [
            "id_search": searchId,
            "with_progress": true,
            "id_captcha": "<null>",
            "status_only": false
        ]
        
        self.currentAction = {
            let task = AF.request(
                Endpoint.search.link(),
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: [
                    "accept": "application/json",
                    "Content-Type": "application/json"
                ]
            ).cacheResponse(using: ResponseCacher.doNotCache)
            
            task.response {
                switch $0.result {
                case .success(let data):
                    if let data {
                        do {
                            let json = try? JSONSerialization.jsonObject(
                                with: data,
                                options: .allowFragments
                            )
                            Log_FaceChecker_UPD.global.info("\(json.debugDescription)")
                            let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                            
                            if let progress = searchResponse.progress {
                                self.progress = progress
                            }
                            
                            let code = FaceCode.fromServer(searchResponse._code)
                            let message = FaceMessage.fromServer(searchResponse.message)
                            
                            switch message {
                            case .searchCompleted:
                                if let items = searchResponse.output?.items {
                                    let output = Dictionary(
                                        grouping: items,
                                        by: \.group
                                    )
                                    
                                    let searchGroups = output.map { group in
                                        SearchGroup(group: group)
                                    }.sorted {
                                        if let firstScore = $0.score, let secondScore = $1.score {
                                            return firstScore > secondScore
                                        } else {
                                            return true
                                        }
                                    }
                                    
                                    self.searchOutput = searchGroups
                                }
                            default:
                                break
                            }
                            
                            self.code = code
                            self.message = message
                        } catch {
                            Log_FaceChecker_UPD.global.error("\(error.localizedDescription)")
                        }
                    }
                case .failure:
                    return
                }
            }
        }
        
        self.timer = Timer(timeInterval: 1.5, repeats: true) { _ in
            self.currentAction?()
        }
        
        self.startTimer(shouldFire: true)
    }
    
    func info() {
        AF.request(
            Endpoint.info.link(),
            method: .post,
            headers: []
        ).response {
            if let response = $0.response {
                Log_FaceChecker_UPD.global.info("info() status: \(response.statusCode.description)")
            }
            
            if let error = $0.error {
                Log_FaceChecker_UPD.global.info("Error: \(error.localizedDescription)")
            }
            
            if let data = $0.data {
                do {
                    let result = try JSONDecoder().decode(InfoResponse.self, from: data)
                    Log_FaceChecker_UPD.global.info("\(result.faces) -- \(result.isOnline)")
                } catch {
                    Log_FaceChecker_UPD.global.info("info() error: \(error.localizedDescription)")
                }
            } else {
                Log_FaceChecker_UPD.global.error("info() There is no data")
            }
        }
    }
}
