//
//  ResultsView.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI

struct ResultsView: View {
    
    // MARK: - Variables
    
    @ObservedObject var networkManager = NetworkManager_FaceChecker_UPD.shared
    
    let image: UIImage
    
    private func getGridColumns(with geo: GeometryProxy) -> [GridItem] {
        if Helper_FaceChecker_UPD.isPadPro {
            return Array(repeating: GridItem(spacing: 9), count: 7)
        } else if Helper_FaceChecker_UPD.isPad {
            return Array(repeating: GridItem(spacing: 9), count: 5)
        } else {
            return Array(repeating: GridItem(spacing: 9), count: Int(geo.size.width) / 150)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.custom.background
                .ignoresSafeArea()
            
            VStack {
                self.headerView
                Spacer()
                self.listView
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                AppRouter_FaceChecker_UPD.shared.setCurrentController(ResultsViewController.self)
            }
        }
    }
    
    // MARK: - Views
    
    private var headerView: some View {
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
        .frame(height: 56)
        .padding(.horizontal, Constant.horizontalPadding)
    }
    
    @ViewBuilder
    private var listView: some View {
        GeometryReader { geo in
            if let searchGroups = self.networkManager.searchOutput {
                ScrollView {
                    LazyVGrid(columns: self.getGridColumns(with: geo)) {
                        ForEach(searchGroups, id: \.self) { group in
                            
                            if let data = group.data,
                               let uiImage = UIImage(data: data),
                               let score = group.score
                            {
                                ResultCell(image: uiImage, score: score)
                                    .onTapGesture {
                                        AppRouter_FaceChecker_UPD.shared.move(
                                            to: .sources(image: uiImage, group: group),
                                            type: .push(animated: true)
                                        )
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

//#Preview {
//    ResultsView(image: UIImage())
//}
