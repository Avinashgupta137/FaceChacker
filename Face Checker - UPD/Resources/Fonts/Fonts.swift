//
//  Fonts.swift
//  Face Checker - UPD
//
//  Created by Systems
//

import SwiftUI

extension Font {
    
    struct DMSans {
        static func bold(size: CGFloat) -> Font {
            Font.custom("DMSans-Bold", size: size)
        }
        
        static func medium(size: CGFloat) -> Font {
            Font.custom("DMSans-Medium", size: size)
        }
        
        static func regular(size: CGFloat) -> Font {
            Font.custom("DMSans-Regular", size: size)
        }
    }
}
