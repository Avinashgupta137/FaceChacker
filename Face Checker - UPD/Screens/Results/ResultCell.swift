//
//  ResultCell.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import SwiftUI

struct ResultCell: View {
    
    // MARK: - Variables
    
    var image: UIImage
    var score: Int
    var isSelected: Bool
    
    var circleColor: Color {
        switch self.score {
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
        switch self.score {
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
            self.imageView
                .frame(width: 100, height: 155)
            self.scoreView
        }
        .frame(minWidth: 100, minHeight: 155)
        .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 5)
            )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var imageView: some View {
        Image(uiImage: self.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    private var scoreView: some View {
        VStack {
            if isSelected {
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundColor(Color.black.opacity(0.2)) // Black with 20% opacity
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.orange)
                            .font(.system(size: 20, weight: .bold)) // Adjust the size and weight as needed
                    }
                    .frame(width: 36, height: 36)
                    .padding(8)
                }
            }
                Spacer()
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color.black.opacity(0.6)) // Black with 20% opacity
                    
                    //                    Circle()
                    //                        .trim(from: 0, to: CGFloat(self.score) / 100)
                    //                        .stroke(self.circleColor, lineWidth: 3.5)
                    //                        .rotationEffect(.degrees(-90))
                    
                    Text("x6")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(width: 36, height: 36)
                .padding(8)
                
                Spacer()
                ZStack {
                    Circle()
                        .foregroundColor(Color.black.opacity(0.6))
                    
//                    Circle()
//                        .trim(from: 0, to: CGFloat(self.score) / 100)
//                        .stroke(self.circleColor, lineWidth: 3.5)
//                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(self.score))%")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(self.textColor)
                }
                .frame(width: 36, height: 36)
                .padding(8)
            }
        }
    }
}

//#Preview {
//    var base64: String {
//        "data:image/webp;base64, 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"
//    }
//    return VStack {
//        ResultCell(item: .init(score: 99, base64: base64))
//        ResultCell(item: .init(score: 92, base64: base64))
//        ResultCell(item: .init(score: 85, base64: base64))
//        ResultCell(item: .init(score: 70, base64: base64))
//    }
//}
