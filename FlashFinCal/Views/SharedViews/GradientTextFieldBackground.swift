//
//  GradientTextFieldBackground.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-09-10.
//

import Foundation
import SwiftUI

struct GradientTextFieldBackground: TextFieldStyle {
    
    let systemImageString: String?
    let colorList: [Color]
    let buttonImageString = "xmark"
    var action: (() -> Void)
    
    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
    
            RoundedRectangle(cornerRadius: 16.0)
                .stroke(
                    LinearGradient(
                        colors: colorList,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 50)
            
            HStack {
                if let value = systemImageString{
                    Image(systemName: value)
                }
                // Reference the TextField here
                configuration
                
                Divider()
                    .frame(height: 40)
                
                Button{
                    action()
                }label: {
                    Image(systemName: buttonImageString)
                }
              
            }
            .padding()
            .foregroundColor(.black)
        }
    }
}


