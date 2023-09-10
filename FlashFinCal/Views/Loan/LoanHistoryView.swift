//
//  LoanHistoryView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-30.
//

import SwiftUI

//struct LoanHistoryView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var loanHistory: FetchedResults<LoanEntity>
//
//
//    func removeLoanItem(at offsets: IndexSet) {
//        for index in offsets {
//            let record = loanHistory[index]
//            moc.delete(record)
//        }
//        do {
//            try moc.save()
//        } catch {
//            // handle the Core Data error
//        }
//    }
//
//    var body: some View {
//        VStack {
//            List {
//
//                ForEach(loanHistory){ loan  in
//
//
//                        if(loan.termInYears != 0){
//                            NavigationLink{
//                                LoanPaymentView(presentValue: loan.loanAmount, interestRate: loan.intRate, termInMonthsPlusOne: ((Int(loan.termInYears) * 12) + 1), compoundTimes: 12)
//                            }label: {
//                                VStack(alignment: .leading){
//                                    Text("Loan Amount: \(loan.loanAmount, specifier: "%.2f")")
//                                        .foregroundColor(.primary)
//
//                                    Text("Term (Y): \(loan.termInYears, specifier: "%.2f")")
//                                        .foregroundColor(.secondary)
//                                                    .font(.subheadline)
//
//
//                                    Text("Interest Rate: \(loan.intRate.formatted(.percent))")
//                                        .foregroundColor(.secondary)
//                                                    .font(.subheadline)
//
//                            }
//                        }
//
//                    }
//
//                }.onDelete(perform: removeLoanItem)
//
//            }
//
//            .navigationTitle("History")
//
//
//
//    }
//    }
//}
//
//struct LoanHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoanHistoryView()
//    }
//}
