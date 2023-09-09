//
//  ViewThree.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct Loan: View {
    @Environment(\.managedObjectContext) var moc
    
    @AppStorage("ln_present_value") var presentValue:Double = 0.00
    @AppStorage("ln_interest_rate") var intRate: Double = 0.0
    @AppStorage("ln_term_in_years") var termInYears: Int = 0
    @AppStorage("ln_future_value") var futureValue:Double = 0.00
    @AppStorage("ln_payment_amount") var paymentAmount: Double = 0.00
    @AppStorage("ln_no_of_payments") var noOfPayments: Int = 12
    @AppStorage("ln_payment_made_on")var paymentMade: Int = 1
    
    @FocusState private var isFocused: FocusedField?
    
    @State private var showingAlert = false
    @State private var showingAmortization = false
    @State private var showingHelpSheet = false
    @State private var errorMassage = ""
    
    
    private let numberFormatter: NumberFormatter
    let doubleFormat = ".2"
    init() {
          numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .currency
          numberFormatter.maximumFractionDigits = 2
        }
    
    enum FocusedField{
        case presentvalue, interestrate, paymentamount, futurevalue
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Form(){
                    Section("Loan Details"){
                        NumericField(numberFormatter: numberFormatter, placeholder: "Investing Amount", labelName: "Amount", fieldValue: $presentValue)
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
                    }
                    
                    Section("Term") {
                        Stepper("Enter Term in Years", value: $termInYears, in: 0...25)
                            .frame(height: 38)
                        HStack {
                            Text("\(termInYears) \(termInYears == 1 ? "Year" : "Years")")
                            Spacer()
                            Image(systemName: "arrow.forward")
                            Spacer()
                            Text("\(Int(termInYears) * 12 ) Months")
                        }
                        .frame(height: 38)
                        
                        
                        Picker("", selection: $noOfPayments) {
                            Text("Annually").tag(1)
                            Text("Semi-Annually").tag(2)
                            Text("Quarterly").tag(4)
                            Text("Monthly").tag(12)
                        }
                        .frame(height: 38)
                        .pickerStyle(.segmented)
//                        Stepper("No of Payments per year", value: $noOfPayments, in: 1...12)
//
//                        HStack {
//                            Text("\(noOfPayments) \(noOfPayments == 1 ? "payment" : "payments") per year")
//                            Spacer()
//
//                        }
//                        .frame(height: 38)
                    }
                    
                    Section("Loan Payment"){

                            NumericField(numberFormatter: numberFormatter, placeholder: "Payment Amount", labelName: "Payment Amount", fieldValue: $paymentAmount)
                                    .focused($isFocused, equals: .paymentamount)
                              
                        }
                    
                    //TODO: to match the loan calculations
                    if(presentValue != 0.00 && intRate != 0.0 && termInYears != 0){
                        NavigationLink("View Loan Payment Table", destination: LoanPaymentView(
                            presentValue: presentValue,
                            interestRate: intRate,
                            termInMonthsPlusOne: (termInYears * 12) + 1,
                                       compoundTimes: 12))
                    }
                }
                VStack{
                    Button("Calculate"){
                        isFocused = nil
                        
                        let inputArray = [presentValue, Double(intRate) , Double(termInYears), paymentAmount]
                        
                        let emptyFields = inputArray.filter({$0 == 0.0})
                        
                        if(emptyFields.count == 0){
                            
                            paymentAmount = Calculation.calculatePMT(
                                annualInterestRate: intRate,
                                numberOfPaymentsPerYear: Double(noOfPayments),
                                principal: presentValue,
                                totalNumberOfPayments: Double(termInYears) * 12.0)
                            
                            let loan = LoanEntity(context: moc)
                            loan.id = UUID()
                            loan.loanAmount = presentValue
                            loan.intRate = intRate
                            loan.termInYears = Int32(termInYears)
                            loan.paymentAmount = paymentAmount
                  
                            
                            
                            try? moc.save()
                            
                        }else if(emptyFields.count > 1){
                            errorMassage = "I can calculate only one field for you..."
                            showingAlert.toggle()
                        }else{
                            
                            if(paymentAmount == 0){
                                paymentAmount = Calculation.calculatePMT(
                                    annualInterestRate: intRate,
                                    numberOfPaymentsPerYear: Double(noOfPayments),
                                    principal: presentValue,
                                    totalNumberOfPayments: Double(termInYears) * 12.0)
                                
                                let loan = LoanEntity(context: moc)
                                loan.id = UUID()
                                loan.loanAmount = presentValue
                                loan.intRate = intRate
                                loan.termInYears = Int32(termInYears)
                                loan.paymentAmount = paymentAmount
                                
                                try? moc.save()
                                
                            }else if(intRate == 0){
                                
                                let rate = Calculation.calculateInterestRateIterativeMethod(principal: presentValue, monthlyPayment: paymentAmount, loanTermInYears: termInYears, isMonthlyInterestRate: false) ?? 0.0
                                
                                intRate =  Double(round(1000 * rate) / 1000)
                                
                                let loan = LoanEntity(context: moc)
                                loan.id = UUID()
                                loan.loanAmount = presentValue
                                loan.intRate = intRate
                                loan.termInYears = Int32(termInYears)
                                loan.paymentAmount = paymentAmount
                                
                                try? moc.save()
                                
                            }else if(termInYears == 0){
                                termInYears = Calculation.calculateLoanTermInYears(principal: presentValue, monthlyPayment: paymentAmount, annualInterestRate: intRate)
                                
                                let loan = LoanEntity(context: moc)
                                loan.id = UUID()
                                loan.loanAmount = presentValue
                                loan.intRate = intRate
                                loan.termInYears = Int32(termInYears)
                                loan.paymentAmount = paymentAmount
                                
                                try? moc.save()
                                
                            }else if (presentValue == 0){
                                presentValue = Calculation.calculateBorrowingAmount(monthlyPayment: paymentAmount, annualInterestRate: intRate, loanTermInYears: termInYears)
                                
                                let loan = LoanEntity(context: moc)
                                loan.id = UUID()
                                loan.loanAmount = presentValue
                                loan.intRate = intRate
                                loan.termInYears = Int32(termInYears)
                                loan.paymentAmount = paymentAmount
                                
                                try? moc.save()
                                
                            }else{
                                errorMassage = "Something went wrong"
                                showingAlert.toggle()
                            }
                        }
                        
                        

                        
                    }
                    .frame(width: 300, alignment: .center)
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .alert(errorMassage, isPresented: $showingAlert) {
                                Button("OK") { }
                            }
                }
                .padding(25)
            }
            .navigationTitle("Loan")
            .toolbar {
                
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        isFocused = nil
                    }
                    
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Help") {
                        showingHelpSheet.toggle()
                        print("Help tapped from Loans")
                    }
                    .sheet(isPresented: $showingHelpSheet) {
                        //TODO: Add help Details
                        HelpView(helpString: HelpText.loanHelpText, fromScreen: "Calculating Loan")
                    }
                    
                    
                }
                ToolbarItemGroup(placement: .secondaryAction){
                    NavigationLink("Saved Records", destination: LoanHistoryView() )
                }
                
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ViewThree_Previews: PreviewProvider {
    static var previews: some View {
        Loan()
    }
}
