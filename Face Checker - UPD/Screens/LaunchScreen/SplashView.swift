//
//  SplashView.swift
//  Face Checker - UPD
//
//  Created by Avinash Gupta on 03/07/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("Indicator") // Ensure this image is in your asset catalog
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 236)
            Spacer()
        }
        // Change to your preferred background color
        .edgesIgnoringSafeArea(.all)
    }
}
