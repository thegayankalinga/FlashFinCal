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
    @State private var showingHelpSheet = false
    @State private var isSavedSelected = false
    
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
            InforCardView(card: Card(icon: "info.square", text: "Please Keep the field you want the value empty"))
                .padding(.top, 40)
                .padding(.horizontal, 10)
            ScrollView{

                VStack{
                    Text("Hi")
                }
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
