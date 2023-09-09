//
//  ViewFour.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct Mortgage: View {
    @AppStorage("mtg_present_value") var presentValue:Double = 0.00
    @AppStorage("mtg_interest_rate") var intRate: Double = 0.00
    @AppStorage("mtg_term_in_months") var termInYears: Int = 0
    @AppStorage("mtg_monthly_payment") var monthlyPayment: Double = 0.00
    
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @State private var showingHelpSheet = false
    
    @FocusState private var isFocused: FocusField?
    enum FocusField{
        case presentvalue, interestrate, monthlypayment
    }
    
    
    private let numberFormatter: NumberFormatter
    init() {
          numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .currency
          numberFormatter.maximumFractionDigits = 2
        }
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    
                    Section("Mortgage Detail"){
                        NumericField(numberFormatter: numberFormatter, placeholder: "Amount", labelName: "Amount", fieldValue: $presentValue)
                            .focused($isFocused, equals: .presentvalue)
                        
                        HStack{
                            Text("Interest Rate")
                            HStack{
                                
                                TextField("Annual Interest Rate", value: $intRate, format: .percent)
                                    .frame(height: 38)
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .focused($isFocused, equals: .interestrate)
                                    .font(.title2)
                            }
                        }
                        
                        NumericField(numberFormatter: numberFormatter, placeholder: "Monthly Payment", labelName: "Monthly Payment", fieldValue: $monthlyPayment)
                            .focused($isFocused, equals: .monthlypayment)
                    }
                    
                    Section("Term") {
                        Stepper("Enter Term in Years", value: $termInYears, in: 0...25)
                            .frame(height: 38)
                        HStack {
                            Text("\(termInYears) Years")
                                .font(.title3)
                            Spacer()//TODO: add year & years separation
                            Image(systemName: "arrow.forward")
                                .font(.title3)
                            Spacer()
                            Text("\(Int(termInYears) * 12 ) Months")
                                .font(.title3)
                            
                        }
                        .frame(height: 38)
                    }
                    
                    //TODO: to match the loan calculations
                    if(presentValue != 0.00 && intRate != 0.0 && termInYears != 0){
                        NavigationLink("View Amortization Table", destination: SavingAmotizationTable(
                            presentValue: presentValue,
                            interestRate: intRate,
                            termInMonthsPlusOne: (termInYears * 12) + 1 ))
                    }
                    
                    
                }
                
                VStack{
                    Button("Calculate"){
                        isFocused = nil
                        
                        let inputFields = [presentValue, intRate, monthlyPayment, Double(termInYears)]
                        let emptyFields = inputFields.filter({$0 == 0})
                        
                        if(emptyFields.count == 0){
                            errorMessage = "Please keep one field empty or 0 to calculate"
                            showingAlert.toggle()
                            
                        } else if(emptyFields.count > 1){
                            errorMessage = "Only one field needs to be empty pls fill all the fields & keep the one field you want the answer empty"
                            showingAlert.toggle()
                        }else{
                            if(presentValue == 0){
                                presentValue = Calculation.calculateBorrowingAmount(monthlyPayment: monthlyPayment, annualInterestRate: intRate, loanTermInYears: termInYears)
                            }else if(intRate == 0){
                                
                                let rate = Calculation.calculateInterestRateIterativeMethod(principal: presentValue, monthlyPayment: monthlyPayment, loanTermInYears: termInYears, isMonthlyInterestRate: false) ?? 0.0
                                
//                                    let rate = Calculation.calculateMonthlyInterestRate(principal: presentValue, monthlyPayment: monthlyPayment, loanTermInYears: termInYears)
                                
                               
                                intRate =  Double(round(1000 * rate) / 1000)
                                
                            }else if(monthlyPayment == 0){
                                
                                monthlyPayment = Calculation.calculateMonthlyMortgagePayment(principal: presentValue, annualInterestRate: intRate, loanTermInYears: termInYears)
                                
                            }else if (termInYears == 0){
                                 
                                termInYears = Calculation.calculateLoanTermInYears(principal: presentValue, monthlyPayment: monthlyPayment, annualInterestRate: intRate)
                                
                            }else{
                                errorMessage = "Something went wrong"
                                showingAlert.toggle()
                            }
                        }
                        
                    }
                    .frame(width: 300, alignment: .center)
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .alert(errorMessage, isPresented: $showingAlert) {
                                Button("OK") { }
                            }
                }
                .padding(25)
            }
            .navigationTitle("Mortgage")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        isFocused = nil
                    }
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Help") {
                        showingHelpSheet.toggle()
                        print("Help tapped from mortgage")
                    }
                    .sheet(isPresented: $showingHelpSheet) {
                        HelpView(helpString: HelpText.mortgageHelpText, fromScreen: "Calculation of Mortgage")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ViewFour_Previews: PreviewProvider {
    static var previews: some View {
        Mortgage()
    }
}
