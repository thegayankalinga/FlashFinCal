//
//  NumbersOnlyViewModifier.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-09-10.
//

//import Foundation
//import SwiftUI
//import Combine
//
//struct NumbersOnlyViewModifier: ViewModifier{
//    @Binding var text: String
//    var includeDecimal: Bool
//
//    func body(content: Content) -> some View {
//        content
//            .keyboardType(includeDecimal ? . decimalPad : .numberPad)
//            .onReceive(Just(text)){ newValue in
//                var numbers = "0123456789"
//
//                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
//
//                if includeDecimal{
//                    numbers += decimalSeparator
//                }
//
//                if newValue.components(separatedBy: decimalSeparator).count-1 > 1{
//                    let filtered = newValue
//                    self.text = String(filtered.dropLast())
//                }else{
//                    let filtered = newValue.filter {numbers.contains($0)}
//                    if filtered != newValue {
//                        self.text = filtered
//                    }
//                }
//
//            }
//    }
//}
//
//extension View{
//    func numberOnly(_ text: Binding<String>, includeDecimal: Bool = false) -> some View{
//        self.modifier(NumbersOnlyViewModifier(text: text, includeDecimal: includeDecimal))
//    }
//}




import Foundation
import SwiftUI
import Combine
struct NumbersOnlyViewModifier: ViewModifier {
    
    @Binding var text: String
    var includeDecimal: Bool
    var digitAllowedAfterDecimal: Int
    

    func body(content: Content) -> some View {
        
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                if includeDecimal {
                    numbers += decimalSeparator
                }
                if newValue.components(separatedBy: decimalSeparator).count-1 > 1 {
                    let filtered = newValue
                    self.text = isValid(newValue: String(filtered.dropLast()), decimalSeparator: decimalSeparator)
                } else {
                    let filtered = newValue.filter { numbers.contains($0)}
                    if filtered != newValue {
                        self.text = isValid(newValue: filtered, decimalSeparator: decimalSeparator)
                    } else {
                        self.text = isValid(newValue: newValue, decimalSeparator: decimalSeparator)
                    }
                }
            }
    }
    
    private func isValid(newValue: String, decimalSeparator: String) -> String {
        guard includeDecimal, !text.isEmpty else { return newValue }
        let component = newValue.components(separatedBy: decimalSeparator)
        if component.count > 1 {
            guard let last = component.last else { return newValue }
            if last.count > digitAllowedAfterDecimal {
                let filtered = newValue
               return String(filtered.dropLast())
            }
        }
        return newValue
    }
}

extension View {
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false, digitAllowedAfterDecimal: Int = 2) -> some View {
        self.modifier(NumbersOnlyViewModifier(text: text, includeDecimal: includeDecimal, digitAllowedAfterDecimal: digitAllowedAfterDecimal))
    }
}
