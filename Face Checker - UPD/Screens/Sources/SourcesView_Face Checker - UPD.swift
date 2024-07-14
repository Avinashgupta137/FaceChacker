//
//  SourcesView.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import SwiftUI
import FaviconFinder

struct SourcesView: View {
    
    // MARK: - Variables
    let imageView = UIImageView()
    
    let image: UIImage
    let group: SearchGroup
    
    private var hosts: [String?] {
        if let items = self.group.items {
            return items.map {
                URL(string: $0.url)?.host
            }
        } else {
            return []
        }
    }
    
    @State private var favicons: [Int: UIImage] = [:]
    
    var circleColor: Color {
        guard let firstItem = self.group.items?.first else { return Color(hex: "#8F98A8") }
        switch firstItem.score {
        case 90...100:
            return Color(hex: "#DA4545")
        case 80...89:
            return Color(hex: "#F89726")
        case 70...79:
            return Color(hex: "#FFDE71")
        default:
            return Color(hex: "#8F98A8")
        }
    }
    
    var textColor: Color {
        guard let firstItem = self.group.items?.first else { return Color.black }
        switch firstItem.score {
        case 90...100:
            return Color(hex: "#DA4545")
        case 80...89:
            return Color(hex: "#F89726")
        default:
            return Color.black
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            Color.custom.background
                .ignoresSafeArea()
            VStack {
                headerView
                .padding(.horizontal, Constant.horizontalPadding)
                ScrollView {
                    ZStack(alignment: .bottomLeading) {
                        Image(uiImage: self.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                
                                if let firstItem = self.group.items?.first {
                                    Circle()
                                        .foregroundColor(Color.black.opacity(0.6))
                                    Text("\(firstItem.score)%")
                                        .font(.DMSans.medium(size: 16))
                                        .foregroundColor(self.textColor)
                                }
                            }
                            .frame(width: 48, height: 48)
                            .padding(.trailing, 24)
                            .padding(.bottom, 16)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .padding(.top, 16)
                    morePhotoVideoView
                        .padding(.horizontal)
                    linksView
                    newsView
                    
                    
                }
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
            Text("Results")
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
                .frame(width: 24)
        }
        .frame(height: 56)
        .padding(.horizontal, Constant.horizontalPadding)
    }
    
    private var photoView: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            self.scoreView
        }
        .frame(width: UIScreen.main.bounds.width - 40)
        .padding(.top, 16)
    }
    private var morePhotoVideoView: some View {
        Button {
            print("Clicked")
        } label: {
            HStack {
                Image(systemName: "photo.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                Text("More Photos & Videos")
                    .foregroundColor(.white)
            }
            .padding()
        }
        .buttonStyle(CustomButtonStyle())
    }
    
    private var scoreView: some View {
           VStack {
               Spacer()
               HStack {
                   Spacer()
                   ZStack {
                       Circle()
                           .foregroundColor(.white)
                       
                       if let firstItem = self.group.items?.first {
                           Circle()
                               .foregroundColor(Color.black.opacity(0.6))
                           Text("\(firstItem.score)%")
                               .font(.DMSans.medium(size: 16))
                               .foregroundColor(self.textColor)
                       }
                   }
                   .frame(width: 48, height: 48)
                   .padding(.trailing, 24)
                   .padding(.bottom, 16)
               }
           }
       }
    
    private var linksView: some View {
           ScrollView(.horizontal, showsIndicators: false) {
               HStack {
                   if let items = self.group.items {
                       ForEach(Array(items.indices), id: \.self) { index in
                           self.linkView(index: index)
                       }
                   }
               }
           }
           .padding(.horizontal, 20)
       }
    private func linkView(index: Int) -> some View {
           Button {
               if let items = self.group.items, let url = URL(string: items[index].url) {
                   UIApplication.shared.open(url)
               }
           } label: {
               ZStack {
                   RoundedRectangle(cornerRadius: 30)
                       .foregroundColor(Color.custom.lightBlack)
                   
                   HStack(spacing: 8) {
                       if let favicon = self.favicons[index] {
                           Image(uiImage: favicon)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 32)
                       } else {
                           Rectangle()
                               .foregroundColor(.white)
                               .frame(width: 32, height: 32)
                       }
                       
                       Text(self.hosts[index] ?? "Check source")
                           .font(.DMSans.medium(size: 16))
                           .foregroundColor(.white)
                           .lineLimit(2)
                       
                       Spacer()
                   }
                   .padding()
               }
           }
           .frame(height: 56)
           .padding(.horizontal, 20)
       }
    
    private var newsView: some View {
        VStack {
            HStack {
                Text("News")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                Spacer()
            }
            ForEach(1..<4) { index in
                newsViewList(index: index)
            }
        }
        .padding(.horizontal, 20)
    }

     private func newsViewList(index: Int) -> some View {
         VStack {
             Image("purchaseBackground")
                 .resizable()
                 .frame(height: 130)
                 .cornerRadius(20)
             Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galle")
                 .foregroundColor(Color.white)
                 .lineLimit(2)
         }
         .padding()
         .background(Color.custom.lightBlack)
         .cornerRadius(20)
     }


    
    // MARK: - Methods
    
    private func getFavicons() {
        // APP REF
        
        func random_FaceChecker_UPD() {
            let _ = "random_FaceChecker_UPD".map {
                $0.uppercased()
            }
        }
        
        //
        
        self.group.items?.indices.forEach { index in
            if let items = self.group.items, let url = URL(string: items[index].url) {
                Task {
                    do {
                        let favicon = try await FaviconFinder(url: url)
                            .fetchFaviconURLs()
                            .download()
                            .smallest()
                        
                        if let faviconImage = favicon.image {
                            let uiImage = UIImage(data: faviconImage.data)
                            DispatchQueue.main.async {
                                self.favicons[index] = uiImage
                            }
                        } else {
                            
                        }
                    } catch let error {
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}
