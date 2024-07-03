//
//  ButtonExt.swift
//  Face Checker - UPD
//
//  Created by Avinash Gupta on 03/07/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var backgroundColor: Color = Color.custom.btnColor
    var cornerRadius: CGFloat = 25
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
        
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .frame(height: 50)
            .cornerRadius(cornerRadius)
         
            
        }
}
