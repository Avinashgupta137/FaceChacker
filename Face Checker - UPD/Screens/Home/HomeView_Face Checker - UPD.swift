//
//  HomeView_FaceChecker_UPD.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI

enum BrowseType {
    case camera
    case gallery
    
    var sourceType: UIImagePickerController.SourceType {
        switch self {
        case .camera:
            return .camera
        case .gallery:
            return .photoLibrary
        }
    }
    
    var image: Image {
        switch self {
        case .camera:
            return Image.custom.cameraIcon
        case .gallery:
            return Image.custom.galleryIcon
        }
    }
    
    var title: String {
        switch self {
        case .camera:
            return "Camera"
        case .gallery:
            return "Gallery"
        }
    }
}

struct HomeView_FaceChecker_UPD: View {
    
    // MARK: - Variables
    
    @State private var showBrowseModal = false
    @State private var modalOffset: CGFloat = 450
    @State private var modalOpacity: Double = 0
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.custom.background
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                self.contentView
                Spacer()
                self.browseButton
                if Helper_FaceChecker_UPD.isPad {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.clear)
                        .padding(.bottom, 40)
                }
            }
            
            self.browseModal
        }
    }
    
    // MARK: - Views
    
    private var headerView: some View {
        HStack {
            Button {
                return
            } label: {
                Image.custom.settings
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
            }
            
            Spacer()
            
            Button {
                return
            } label: {
                Image.custom.crown
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
            }
        }
        .frame(height: 56)
        .padding(.horizontal, Constant.horizontalPadding)
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            Image.custom.homeLogo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 236)
            
            Text("Face Check")
                .font(.DMSans.medium(size: 32))
                .foregroundColor(.white)
            
            Text("Drop photo of the person you want to find.")
                .font(.DMSans.regular(size: 20))
                .foregroundColor(.white)
                .frame(width: 250)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
    
    private var browseButton: some View {
        Button {
            self.showBrowseModal = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.custom.accentGreen)
                
                Text("Browse...")
                    .font(.DMSans.regular(size: 18))
                    .foregroundColor(.white)
            }
        }
        .frame(height: 44)
        .padding(.horizontal, Constant.horizontalPadding)
        .padding(.bottom, 16)
    }
    
    private var browseModal: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.25)
                .onTapGesture {
                    self.showBrowseModal = false
                }
                .opacity(self.modalOpacity)
                .animation(.linear(duration: 0.2), value: self.modalOpacity)
                .onChange(of: self.showBrowseModal) { showBrowseModal in
                    if showBrowseModal {
                        self.modalOpacity = 1
                    } else {
                        DispatchQueue.main.asyncAfter(
                            deadline: .now().advanced(by: .milliseconds(100))
                        ) {
                            self.modalOpacity = 0
                        }
                    }
                }
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.custom.lightBlack)
                
                self.browseModalContent
            }
            .frame(height: 256)
            .offset(y: self.modalOffset)
            .animation(.easeInOut(duration: 0.3), value: self.modalOffset)
            .onChange(of: self.modalOpacity) { modalOpacity in
                if modalOpacity == 1 {
                    DispatchQueue.main.asyncAfter(
                        deadline: .now().advanced(by: .milliseconds(75))
                    ) {
                        self.modalOffset = 0
                    }
                } else {
                    self.modalOffset = 450
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private var browseModalContent: some View {
        VStack(spacing: 16) {
            Text("Browse...")
                .font(.DMSans.bold(size: 20))
                .foregroundColor(.white)
            
            VStack(spacing: 10) {
                self.browseModalCell(type: .camera)
                self.browseModalCell(type: .gallery)
            }
        }
        .padding(Constant.smallHorizontalPadding)
    }
    
    private func browseModalCell(type: BrowseType) -> some View {
        Button {
            AppRouter_FaceChecker_UPD.shared.move(
                to: .browse(type: type),
                type: .present(animated: true)
            )
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.custom.darkGray)
                
                HStack(spacing: 16) {
                    type.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34)
                    
                    Text(type.title)
                        .font(.DMSans.regular(size: 18))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal, Constant.smallHorizontalPadding)
            }
        }
        .frame(height: 66)
    }
}

//#Preview {
//    HomeView_FaceChecker_UPD()
//}
