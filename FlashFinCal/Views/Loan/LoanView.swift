//
//  ViewThree.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct LoanView: View {
    @Environment(\.managedObjectContext) var moc
    
    @StateObject var loan: Loan
    
    @State private var showingAlert = false
    @State private var showHelpCard = true
    @State private var showingHelpSheet = false
    @State private var isSavedSelected = false
    @State private var borrowingAmount = ""
    @State private var annualInterestRate = ""
    
    @FocusState private var isFocused: FocusedField?

    
    enum FocusedField{
        case borrowingAmount,
             annualInterestRate,
             termsInMonths,
             paymentPerYear,
             installmentAmount,
             interestSubsidicedPercentage,
             paymentStartDate
    }
    
    var body: some View {
        NavigationStack{
          
            ScrollView{
                //Info card at first go
                if(showHelpCard){
                    withAnimation(.default.delay(20)){
                        InforCardView(showInfoCard: $showHelpCard, card: Card(icon: "info.square", text: "Please Keep the field you want the value empty"))
                            .padding(.top, 40)
                            .padding(.horizontal, 10)
                    }

                }
                
                VStack{
                    GroupBox("Loan Detail"){
                        EntryField(
                            bindingField: $borrowingAmount,
                            placeholder: "Borrowing Amount",
                            promptText: "",
                            isSecure: false
                        )
                            
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(
                                GradientTextFieldBackground(
                                    systemImageString: "creditcard.circle.fill",
                                    currencyField: true,
                                    colorList: [.black],
                                    value: $borrowingAmount))
                        .numbersOnly($borrowingAmount, includeDecimal: true, digitAllowedAfterDecimal: 2)
                        
                        EntryField(bindingField: $annualInterestRate, placeholder: "Annual Interest Rate %", promptText: "", isSecure: false)
                    }
                    .tint(.cyan)
                    
                    GroupBox("Term Detail"){
                        
                        Text(Locale.current.currency?.identifier ?? "LKR")
                    }
                    
                    GroupBox("Payment Detail"){
                        
                    }
                }
                .offset(y: 40)
            }
            .navigationTitle("Loan Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                //Help View
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        //TODO: help view sheet
                    }label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
                
                //Saved Record
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        //TODO: saved loan calculation record
                    }label: {
                        Image(systemName: "externaldrive.badge.checkmark")
                    }
                }
                
                //Clear all
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        //TODO: clear all values
                    }label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
            }
        }
        
    }
}

struct LoanView_Previews: PreviewProvider {

    static var previews: some View {
        LoanView(loan: Loan(
            borrowedAmount: 125000,
            annualInterestRate: 12,
            termInMonths: 36,
            paymentsPerYear: 12,
            installmentAmount: 25000,
            paymentMadeAtEnd: false,
            interestSubsidicedPercentage: 0.25,
            paymentStartDate: Date.now)
        )
    }
}
