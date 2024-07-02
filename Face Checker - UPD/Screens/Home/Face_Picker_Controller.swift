//
//  Face_Picker_Controller.swift
//  Face Checker - UPD
//
//  Created by Avinash Gupta on 02/07/24.
//


import SwiftUI

struct Face_Picker_Controller: View {
    var body: some View {
        ZStack {
            Color.custom.background
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 30) {
                    VStack(spacing: 10) {
                        Text("Face Check")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Drop photo of the person you want to find")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 30)
                    Image("BiomatricImg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .padding(.bottom, 30)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.custom.lightBlack)
                )
                .padding(.horizontal, 20)
                Spacer()
                VStack {
                    Button("Choose Photo") {
                        // Button action
                    }
                    .buttonStyle(CustomButtonStyle())
                    .padding(20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.custom.lightBlack)
                        .ignoresSafeArea(.container, edges: .bottom)
                )
            }
        }
    }
}

struct Face_Picker_Controller_Previews: PreviewProvider {
    static var previews: some View {
        Face_Picker_Controller()
    }
}
