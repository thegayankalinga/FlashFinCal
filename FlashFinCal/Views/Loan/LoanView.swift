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
    @State private var showingAmortization = false
    @State private var showingHelpSheet = false
    @State private var errorMassage = ""
    @State private var isSavedSelected = false
    
    @FocusState private var isFocused: FocusedField?
    
    enum FocusedField{
        case presentvalue, interestrate, paymentamount, futurevalue
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    
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
