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
    let currencyCode: String = Locale.current.currency?.identifier ?? "USD"
    let currencyField: Bool
    let colorList: [Color]
    let buttonImageString = "xmark"
    @Binding var value: String
    
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
                
                if currencyField {
                    Text(currencyCode)
                }
                // Reference the TextField here
                configuration
                
                Divider()
                    .frame(height: 40)
                
                Button{
                    value = ""
                }label: {
                    Image(systemName: buttonImageString)
                }
              
            }
            .padding()
            .foregroundColor(.black)
        }
    }
}


