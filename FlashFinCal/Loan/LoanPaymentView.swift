//
//  LoanPaymentView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-30.
//

import SwiftUI

struct LoanPaymentView: View {
    var presentValue: Double
    var interestRate: Double
    var termInMonthsPlusOne: Int
    var compoundTimes: Int
    
    var body: some View {
        VStack (alignment: .leading ){
            Text("For Loan Amount\(presentValue.format(f: ".2"))")
            Divider()
                .frame(height: 20)
            Text("")
            ScrollView {
                LazyVStack{
                        HStack{
                            Text("Month")
                                .font(.headline)
                            Spacer()
                            Text("Interest")
                                .font(.headline)
                            Spacer()
                            Text("Capital")
                                .font(.headline)
                            Spacer()
                            Text("Installment")
                                .font(.headline)
                        }
                    
                         ForEach(1..<termInMonthsPlusOne, id: \.self) { value in
                             
                             HStack{
                                 let ipmt = Calculation.calculateIPMT(
                                    principal: presentValue,
                                    annualInterestRate: interestRate,
                                    numberOfPaymentsPerYear: Double(compoundTimes),
                                    period: value,
                                    term: (termInMonthsPlusOne)-1)
                                 
                                 let ppmt = Calculation.calculatePPMT(
                                    principal: presentValue,
                                    annualInterestRate: interestRate,
                                    numberOfPaymentsPerYear: Double(compoundTimes),
                                    period: Double(value),
                                    totalNumberOfPayments: Double((termInMonthsPlusOne)-1))
                                 
                                 let pmt = Calculation.calculatePMT(
                                    annualInterestRate: interestRate,
                                    numberOfPaymentsPerYear: Double(compoundTimes),
                                    principal: presentValue,
                                    totalNumberOfPayments: Double((termInMonthsPlusOne)-1))
                                 
                                 Text(String(value))
                                 Spacer()
                                 Text(String(ipmt.format(f: ".2")))
                                 Spacer()
                                 
                                 Text(String(ppmt.format(f: ".2")))
                                 Spacer()
                                 
                                 Text(String(pmt.format(f: ".2")))
                   
                                 
                                 
                             }
                             
                            }
                }
            }
            .navigationTitle("Loan Payment Table")
        
            }.padding(25)
    }
}

struct LoanPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        LoanPaymentView(presentValue: 100000, interestRate: 0.10, termInMonthsPlusOne: 37, compoundTimes: 12)
    }
}
