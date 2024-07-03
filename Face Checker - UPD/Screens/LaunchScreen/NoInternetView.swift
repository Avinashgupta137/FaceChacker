//
//  NoInternetView.swift
//  Face Checker - UPD
//
//  Created by Avinash Gupta on 03/07/24.
//

import SwiftUI

struct NoInternetView: View {
    var retryAction: () -> Void

    var body: some View {
        ZStack {
            Color.custom.background
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 30) {
                    Image("Signalimg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    VStack(spacing: 5) {
                        Text("No Internet Connection")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Check your connection and try again")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    Button("Okay") {
                        retryAction()
                    }
                    .buttonStyle(CustomButtonStyle())
                   
                    
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.custom.lightBlack)
                )
                .padding(.horizontal, 20)
                Spacer()
            }
        }
    }
}
struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView(retryAction: {
            // Action to perform on button tap during the preview
            print("Retry button tapped")
        })
    }
}
