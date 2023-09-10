//
////  ViewTwo.swift
////  FlashFinCal
////
////  Created by Gayan Kalinga on 2023-07-23.
////
//
//import SwiftUI
//import Foundation
//
//extension Double {
//    func format(f: String) -> String {
//        return String(format: "%\(f)f", self)
//    }
//}
//
//struct Saving: View {
//
//    @Environment(\.managedObjectContext) var moc
//    
//    @AppStorage("present_value") var presentValue:Double = 0.00
//    @AppStorage("interest_rate") var intRate: Double = 0.0
//    @AppStorage("term_in_years") var termInYears: Int = 0
//    @AppStorage("future_value") var futureValue:Double = 0.00
//    @AppStorage("show_payments") var showPayment: Bool = false
//    @AppStorage("payment_amount") var paymentAmount: Double = 0.00
//    @AppStorage("no_of_payments") var noOfPayments: Int = 12
//    @AppStorage("payment_made_on")var paymentMade: Int = 1
//    
//    @FocusState private var isFocused: FocusedField?
//    
//  
//    @State private var showingAlert = false
//    @State private var showingAmortization = false
//    @State private var showingHelpSheet = false
//    @State private var errorMassage = ""
//    @State var returnValue = 0.00
//    
//    private let numberFormatter: NumberFormatter
//    let doubleFormat = ".2"
//    
//    
//    init() {
//          numberFormatter = NumberFormatter()
//          numberFormatter.numberStyle = .currency
//          numberFormatter.maximumFractionDigits = 2
//        }
//    
//    enum FocusedField{
//        case presentvalue, interestrate, paymentamount, futurevalue
//    }
//
//  
//
//
//    var body: some View {
//        
//        NavigationView{
//            VStack {
//               
//                Form(){
//                    
//                    //MARK:- Saving Detail
//                    Section("Saving Detail") {
//                        NumericField(numberFormatter: numberFormatter, placeholder: "Investing Amount", labelName: "Amount", fieldValue: $presentValue)
//                            .focused($isFocused, equals: .presentvalue)
//
//                        NumericField(numberFormatter: numberFormatter, placeholder: "Future Expected Value", labelName: "Future Value", fieldValue: $futureValue)
//                            .focused($isFocused, equals: .futurevalue)
//
//                        HStack{
//                            Text("Interest Rate")
//                            HStack{
//                                
//                                TextField("Annual Interest Rate", value: $intRate, format: .percent)
//                                    .frame(height: 38)
//                                //.textFieldStyle(RoundedBorderTextFieldStyle())
//                                    .multilineTextAlignment(.trailing)
//                                    .keyboardType(.decimalPad)
//                                    .focused($isFocused, equals: .interestrate)
//                                    .font(.title2)
//                            }
//                        }
//
//                    }
//                    
//                    
//                    //MARK:- Term Detail
//                    Section("Term") {
//                        Stepper("Enter Term in Years", value: $termInYears, in: 0...25)
//                            .frame(height: 38)
//                        HStack {
//                            Text("\(termInYears) \(termInYears == 1 ? "Year" : "Years")")
//                                .font(.title3)
//                            Spacer()//TODO: add year & years separation
//                            Image(systemName: "arrow.forward")
//                                .font(.title3)
//                            Spacer()
//                            Text("\(Int(termInYears) * 12 ) Months")
//                                .font(.title3)
//                            
//                        }
//                        .frame(height: 38)
//                    }
//                    
//                    
//                    
//                    //MARK: - Recurring Regular Detail
//                    Section("Regular Payment"){
//                        Toggle("Make Payments", isOn: $showPayment.animation())
//                        
//                        if(showPayment){
//                            NumericField(numberFormatter: numberFormatter, placeholder: "Payment Amount", labelName: "Payment amount", fieldValue: $paymentAmount)
//                                    .focused($isFocused, equals: .paymentamount)
//                            
//                            Text("Total of \(termInYears * 12) monthly payments")
//                                
//                            //Stepper("\(noOfPayments) Payments", value: $noOfPayments, in: 1...12)
//                            
//                            
//                            Picker("", selection: $paymentMade) {
//                                Text("At Begning").tag(0)
//                                Text("At End").tag(1)
//                            }
//                            .frame(height: 38)
//                            .pickerStyle(.segmented)
//                            
//                            }
//                         
//                           
//                        }
//                    if(presentValue != 0.00 && intRate != 0.0 && termInYears != 0){
//                        NavigationLink("View Amortization Table", destination: SavingAmotizationTable(
//                            presentValue: presentValue,
//                            interestRate: intRate,
//                            termInMonthsPlusOne: (termInYears * 12) + 1 ))
//                    }
//                    
//                    }
//                
//                VStack{
//                    Button("Calculate"){
//                        isFocused = nil
//                        
//                        
//                        
//                        let inputArray = [presentValue , futureValue, Double(intRate) , Double(termInYears) ]
//                        
//                        let emptyFields = inputArray.filter({$0 == 0.0})
//                        
//                        
//                        if(showPayment == false){
//                            if(emptyFields.count == 0){
//                                
//                                errorMassage = "Please clear one field which you want to calculate"
//                                showingAlert.toggle()
//                                
//                                
//                            }else if(emptyFields.count > 1){
//                                
//                                errorMassage = "You can left out one field for calculation, Pls provide the values for fields except one"
//                                
//                            }else{
//                                
//                                if(futureValue == 0.00){
//                                    
//                                    futureValue = Calculation.calculateFutureValue(presentValue: presentValue, annualInterestRate: intRate, noOfYears: termInYears)
//                                    
//                                    let saving = SavingEntity(context: moc)
//                                    saving.id = UUID()
//                                    saving.presentValue = presentValue
//                                    saving.interestRate = intRate
//                                    saving.termInYears = Int32(termInYears)
//                                    saving.paymentAmount = paymentAmount
//                                    saving.paymentAt = Int16(paymentMade)
//                                    saving.paymentSequence = showPayment
//                                    
//                                    
//                                    try? moc.save()
//                            
//                                }else if(presentValue == 0.00){
//                                    
//                                    presentValue = Calculation.calculatePresentValue(futureValue: futureValue, annualInterestRate: intRate, noOfYears: termInYears)
//                                    
//                                    let saving = SavingEntity(context: moc)
//                                    saving.id = UUID()
//                                    saving.presentValue = presentValue
//                                    saving.interestRate = intRate
//                                    saving.termInYears = Int32(termInYears)
//                                    saving.paymentAmount = paymentAmount
//                                    saving.paymentAt = Int16(paymentMade)
//                                    saving.paymentSequence = showPayment
//                                    
//                                    
//                                    try? moc.save()
//                                    
//                                }else if(termInYears == 0){
//                                    
//                                    termInYears = Int(Calculation.calculateRequiredPeriodInMonths(presentValue: presentValue, futureValue: futureValue, annualInterestRate: intRate))
//                                    
//                        
//                                    
//                                    let saving = SavingEntity(context: moc)
//                                    saving.id = UUID()
//                                    saving.presentValue = presentValue
//                                    saving.interestRate = intRate
//                                    saving.termInYears = Int32(termInYears)
//                                    saving.paymentAmount = paymentAmount
//                                    saving.paymentAt = Int16(paymentMade)
//                                    saving.paymentSequence = showPayment
//                                    
//                                    
//                                    try? moc.save()
//                                    
//                                    
//                                }else if(intRate == 0.00){
//                                    
//                                    intRate = Calculation.calculateAnnualInterestRate(presentValue: presentValue, futureValue: futureValue, noOfYears: termInYears)
//                                    
//                                    let saving = SavingEntity(context: moc)
//                                    saving.id = UUID()
//                                    saving.presentValue = presentValue
//                                    saving.interestRate = intRate
//                                    saving.termInYears = Int32(termInYears)
//                                    saving.paymentAmount = paymentAmount
//                                    saving.paymentAt = Int16(paymentMade)
//                                    saving.paymentSequence = showPayment
//                                    
//                                    
//                                    try? moc.save()
//                                    
//                                    
//                                }else{
//                                    
//                                    errorMassage = "Something Went Wrong"
//                                    showingAlert.toggle()
//                                    
//                                }
//                                
//                            }
//                        }else{
//                            
//                            if(futureValue == 0.00){
//                                let compoundInterest = Calculation.calculateCompoundInterest(principal: presentValue, annualInterestRate: intRate, years: Double(termInYears))
//                                var seriesFutureValue = 0.00
//                                
//                                if(paymentMade == 0){
//                                    
//                                    seriesFutureValue = Calculation.calculateFutureValueOfSeriesBeginingOfThePeriod(
//                                        paymentPerPeriod: Double(paymentAmount) ,
//                                        annualInterestRate: intRate,
//                                        years: termInYears)
//                                    
//                                }else{
//                                    
//                                    seriesFutureValue = Calculation.calculateFutureValueOfSeriesEndOfThePeriod(
//                                        paymentPerPeriod: Double(paymentAmount) ,
//                                        annualInterestRate: intRate,
//                                        years: termInYears)
//                                    
//                                }
//                                
//                                let totalFutureValue = compoundInterest + seriesFutureValue
//                                futureValue = totalFutureValue
//                                
//                                let saving = SavingEntity(context: moc)
//                                saving.id = UUID()
//                                saving.presentValue = presentValue
//                                saving.interestRate = intRate
//                                saving.termInYears = Int32(termInYears)
//                                saving.paymentAmount = paymentAmount
//                                saving.paymentAt = Int16(paymentMade)
//                                saving.paymentSequence = showPayment
//                                
//                                
//                                try? moc.save()
//                                
//                                
//                            }else if(presentValue == 0.00){
//                                
//                                presentValue = Calculation.calculatePresentValueOfAnnuity(futureValue: futureValue, annualInterestRate: intRate, paymentAmount: paymentAmount, termInYears: termInYears, paymentMadeAtBegining: paymentMade == 0 ? true : false)
//                                
//                                let saving = SavingEntity(context: moc)
//                                saving.id = UUID()
//                                saving.presentValue = presentValue
//                                saving.interestRate = intRate
//                                saving.termInYears = Int32(termInYears)
//                                saving.paymentAmount = paymentAmount
//                                saving.paymentAt = Int16(paymentMade)
//                                saving.paymentSequence = showPayment
//                                
//                                
//                                try? moc.save()
//                                
//                        
//                            }else{
//                                errorMassage = "I can only calcualte future value & preesnt value for regular payment scenrios"
//                                showingAlert.toggle()
//                            }
//                        }
//
//                        
//                    }
//                    .frame(width: 300, alignment: .center)
//                    .padding()
//                    .background(Color(red: 0, green: 0, blue: 0.5))
//                    .foregroundStyle(.white)
//                    .clipShape(Capsule())
//                    .alert(errorMassage, isPresented: $showingAlert) {
//                                Button("OK") { }
//                            }
//                }
//                .padding(25)
//  
//                }
//            
//                .navigationTitle("Savings")
//                .toolbar {
//                    
//                    ToolbarItem(placement: .keyboard) {
//                        Button("Done") {
//                            isFocused = nil
//                        }
//                        
//                    }
//                    ToolbarItemGroup(placement: .primaryAction) {
//                        Button("Help") {
//                            showingHelpSheet.toggle()
//                            print("Help tapped from saving")
//                        }
//                        .sheet(isPresented: $showingHelpSheet) {
//                            //TODO: Add help Details
//                            
//                            HelpView(helpString: HelpText.savingHelp, fromScreen: "Calculating Saving")
//                        }
//                        
//                        
//                    }
//                    ToolbarItemGroup(placement: .secondaryAction){
//                        NavigationLink("Saved Records", destination: SavingHistoryView() )
//                    }
//                    
//                }
//                
//            }
//        .navigationViewStyle(.stack)
//   
//        }
//        
//    }
//    
//
//
//
//
//struct ViewTwo_Previews: PreviewProvider {
//    static var previews: some View {
//        Saving()
//    }
//}
//
//
/////How to pass the managed context to subviews
////struct SubContentView: View {
////    @ObservedObject var filter: Filter
////
////    var body: some View {
////        Text("Hello, World!")
////        //All the parts depending on `filter`.
////        //...
////    }
////}
////struct ContentView: View {
////    @Environment(\.managedObjectContext) var context
////
////    var body: some View {
////        SubContentView(filter: Filter(context: context))
////    }
////}
