//
//  EntryField.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-09-10.
//

import SwiftUI

struct EntryField: View {
    
    @Binding var bindingField: String
    
    var placeholder: String
    var promptText: String
    var isSecure: Bool
    var label: String = ""

    
    var body: some View {
        VStack(alignment: .leading){
            Text(label)
            .fixedSize(horizontal: false, vertical: true)
            .font(.caption)
            .padding(.bottom, -10)
            
            if(isSecure){
                SecureField(placeholder, text: $bindingField).autocapitalization(.none)
            }else{
                TextField(placeholder, text: $bindingField).autocapitalization(.none)
            }
            
            Text(promptText)
            .fixedSize(horizontal: false, vertical: true)
            .font(.caption)
            .foregroundColor(.red)

        }
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(bindingField: .constant("Value"), placeholder: "placeholder", promptText: "Value", isSecure: false, label: "Test Label")
    }
}
