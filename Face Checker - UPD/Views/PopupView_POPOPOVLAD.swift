//
//  PopupView.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI

struct PopupView: View {
    
    enum PopupType {
        case queue
        case purchase
    }
    
    // MARK: - Variables
    
    public let type: PopupType
    
    @ObservedObject var networkManager: NetworkManager_FaceChecker_UPD = NetworkManager_FaceChecker_UPD.shared
    @State private var rotationDegrees: CGFloat = 0
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.custom.popup)
                
                VStack(spacing: 16) {
                    ProgressViewRepresentable()
                        .frame(width: 110, height: 110)
                    
                    if self.type == .queue {
                        self.queueText
                    }
                }
            }
            .frame(height: 280)
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Views
    
    private var loaderView: some View {
        Image.custom.loader
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 160)
            .foregroundColor(.custom.accentGreen)
            .rotationEffect(.degrees(self.rotationDegrees))
            .onAppear {
                self.rotationDegrees = 360
            }
            .animation(
                .linear(duration: 2).repeatForever(autoreverses: false),
                value: self.rotationDegrees
            )
    }
    
    private var queueText: some View {
        VStack(spacing: 2) {
            Text("Waiting...")
                .font(.DMSans.medium(size: 24))
                .foregroundColor(.white)
            
            if let queuePlace = self.networkManager.queuePlace {
                Text("Your place in queue: \(queuePlace)")
                    .font(.DMSans.regular(size: 20))
                    .foregroundColor(.custom.lightGray)
            }
        }
    }
}

struct ProgressViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let size: CGFloat = 110
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        let indicator = UIActivityIndicatorView(style: .large)
        let scale = size / indicator.frame.size.width
        indicator.transform = CGAffineTransform(scaleX: scale, y: scale)
        indicator.frame = view.bounds
        indicator.color = UIColor(Color.custom.accentGreen)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        view.addSubview(indicator)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        return
    }
}
