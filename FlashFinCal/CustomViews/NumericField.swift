//
//  SwiftUIView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-29.
//

import SwiftUI

struct NumericField: View {
    
    var numberFormatter: NumberFormatter
    var placeholder: String
    var labelName: String
    @Binding var fieldValue: Double
    
    var body: some View {
        HStack(){
            Text(labelName)
            
            ZStack(alignment: .trailing){
                TextField(placeholder, value: $fieldValue, formatter: numberFormatter)
                    .frame(height: 38)
                //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .font(.title2)
                    .padding(.trailing, 35)
                
                Button{
                    fieldValue = 0.00
                }label: {
                    Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                }
                .frame(width: 35)
                
            }
            
        }
    }
}


