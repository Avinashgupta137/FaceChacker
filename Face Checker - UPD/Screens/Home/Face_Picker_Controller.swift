//
//  Face_Picker_Controller.swift
//  Face Checker - UPD
//
//  Created by Avinash Gupta on 02/07/24.
//


import SwiftUI

struct Face_Picker_Controller: View {
    @State private var isShowingAlert = false
    
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
                        isShowingAlert.toggle()  // Toggle the alert visibility when the button is tapped
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
        .alert(isPresented: $isShowingAlert) {  // Bind the alert to the state
            Alert(
                title: Text("Choose Photo"),
                message: Text("Select a source"),
                primaryButton: .default(Text("Camera")) {
                    AppRouter_FaceChecker_UPD.shared.move(
                        to: .browse(type: .camera),
                        type: .present(animated: true)
                    )
                },
                secondaryButton: .default(Text("Gallery")) {
                    AppRouter_FaceChecker_UPD.shared.move(
                        to: .browse(type: .gallery),
                        type: .present(animated: true)
                    )
                }
            )
        }
    }
}

struct Face_Picker_Controller_Previews: PreviewProvider {
    static var previews: some View {
        Face_Picker_Controller()
    }
}
