//
//  CheckView.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI

struct CheckView: View {
    
    // MARK: - Variables
    
    let image: UIImage
    
    @ObservedObject var networkManager = NetworkManager_FaceChecker_UPD.shared
    @State private var isChecking = false
    @State private var loaderOffset: CGFloat = 0
    @State private var loadingProgress: CGFloat = 0
    @State private var shouldShowAlert = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.custom.background
                .ignoresSafeArea()
            
            VStack {
                self.headerView
                Spacer()
                self.photoView
                Spacer()
                self.checkButton
                if Helper_FaceChecker_UPD.isPad {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.clear)
                        .padding(.bottom, 40)
                }
            }
            
            self.queueView
        }
        .onChange(of: self.networkManager.searchCompleted) { searchCompleted in
            if searchCompleted {
                AppRouter_FaceChecker_UPD.shared.move(
                    to: .results(image: self.image),
                    type: .push(animated: true)
                )
            }
        }
        .onChange(of: self.networkManager.shouldShowAlert) { shouldShowAlert in
            self.shouldShowAlert = shouldShowAlert
        }
        .onChange(of: self.networkManager.shouldShowImageError) { newValue in
            self.shouldShowAlert = true
        }
        .alert(isPresented: self.$shouldShowAlert) {
            Alert(
                title: Text("Image error"),
                message: Text("Your image was not recognized as a valid face. Please try to upload a higher-quality image with a clear face."),
                dismissButton: .cancel(Text("OK")) {
                    AppRouter_FaceChecker_UPD.shared.back()
                    self.networkManager.resetState()
                }
            )
        }
    }
    
    // MARK: - Views
    
    private var headerView: some View {
        ZStack(alignment: .center) {
            HStack {
                Button {
                    AppRouter_FaceChecker_UPD.shared.back()
                } label: {
                    Image.custom.back
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("FaceChecker_UPD")
                    .font(.DMSans.medium(size: 32))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .frame(height: 56)
        .padding(.horizontal, Constant.horizontalPadding)
        .opacity(self.isChecking ? 0 : 1)
        .animation(.linear(duration: 0.125), value: self.isChecking)
    }
    
    @ViewBuilder
    private var queueView: some View {
        switch self.networkManager.message {
        case .queue:
            PopupView(type: .queue)
        default:
            EmptyView()
        }
    }
    
    private var photoView: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(self.loaderView, alignment: .bottom)
                .clipped()
        }
        .frame(width: UIScreen.main.bounds.width - 40)
    }
    
    private var loaderView: some View {
        GeometryReader { geometry in
            Image.custom.photoLoader
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width)
                .offset(y: self.loaderOffset)
                .animation(.linear(duration: 3), value: self.loaderOffset)
                .onAppear {
                    withoutAnimation_POPOPOVLAD {
                        self.loaderOffset = geometry.size.height
                    }
                }
                .onChange(of: self.isChecking) { isChecking in
                    if isChecking {
                        self.loaderOffset = -100
                        self.repeatAnimation(geometry: geometry)
                    }
                }
        }
    }
    
    private var checkButton: some View {
        Button {
            NetworkManager_FaceChecker_UPD.shared.isInternetConnected {
                self.isChecking.toggle()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.networkManager.upload(photo: self.image)
                    //                        self.networkManager.search(searchId: "ZObffggRBS0")
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(self.loadingProgress > 0 ? .custom.lightGray : .custom.accentGreen)
                    .overlay(self.loadingCheckButton, alignment: .center)
                    .clipped()
                
                if self.isChecking == false {
                    Text("Check This Face")
                        .font(.DMSans.regular(size: 18))
                        .foregroundColor(.white)
                }
            }
        }
        .frame(height: 44)
        .padding(.horizontal, Constant.horizontalPadding)
        .padding(.bottom, 26)
        .disabled(self.isChecking || self.networkManager.didStartSearch)
    }
    
    private func isMoreThan7DaysApart(from date1: Date, to date2: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date1, to: date2)

        if let days = components.day, abs(days) > 7 {
            return true
        } else {
            return false
        }
    }
    
    private var loadingButtonGradient: LinearGradient {
        let progress = CGFloat(networkManager.progress) / 100.0
        return LinearGradient(
            stops: [
                .init(color: .custom.accentGreen, location: 0),
                .init(color: .custom.accentGreen, location: progress + 0.001),
                .init(color: .custom.lightGray, location: progress + 0.002),
                .init(color: .custom.lightGray, location: 100.005)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    @ViewBuilder
    private var loadingCheckButton: some View {
        let progress = self.networkManager.progress
        if self.isChecking || self.networkManager.didStartSearch {
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(self.loadingButtonGradient)
                        .frame(width: geometry.size.width)
                        .animation(.linear, value: progress)
                    
                    HStack(spacing: 0) {
                        Text("Searching face.........")
                            .font(.DMSans.regular(size: 18))
                            .foregroundColor(.white)
                        
                        Text("\(String(format: "%02d", progress))%")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.white)
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Methods
    
    private func repeatAnimation(geometry: GeometryProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .seconds(3))) {
            if self.isChecking {
                withoutAnimation_POPOPOVLAD {
                    self.loaderOffset = geometry.size.height
                }
                self.loaderOffset = -100
                self.repeatAnimation(geometry: geometry)
            }
        }
    }

}

//#Preview {
//    CheckView(image: UIImage())
//}
