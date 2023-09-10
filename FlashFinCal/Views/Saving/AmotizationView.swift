////
////  SwiftUIView.swift
////  FlashFinCal
////
////  Created by Gayan Kalinga on 2023-07-30.
//
////
//import Foundation
//import SwiftUI
//
//struct SavingAmotizationTable: View {
//    var presentValue: Double
//    var interestRate: Double
//    var termInMonthsPlusOne: Int
//    
//    var body: some View {
//        
//            VStack (alignment: .leading ){
//                Text("For \(presentValue.format(f: ".2"))")
//                Divider()
//                    .frame(height: 20)
//                Text("")
//                ScrollView {
//                    LazyVStack{
//                            HStack{
//                                Text("Month")
//                                    .font(.headline)
//                                Spacer()
//                                Text("Interest")
//                                    .font(.headline)
//                                Spacer()
//                                Text("Capital")
//                                    .font(.headline)
//                            }
//                        
//                             ForEach(1..<termInMonthsPlusOne, id: \.self) { value in
//                                 
//                                 HStack{
//                                     
//                                     let future = Calculation.calculateFutureValueMonthly(
//                                        presentValue: presentValue,
//                                        annualInterestRate: interestRate,
//                                        noOfYears: value)
//                                     
//                                     let previousFuture  = Calculation.calculateFutureValueMonthly(
//                                            presentValue: presentValue,
//                                            annualInterestRate: interestRate,
//                                            noOfYears: value-1)
//                                 
//                                     
//                                     Text(String(value))
//                                     Spacer()
//                                     Text(String(future.format(f: ".2")))
//                                     Spacer()
//                                     
//                                     Text(String((future - previousFuture).format(f: ".2")))
//                       
//                                     
//                                     
//                                 }
//                                 
//                                }
//                    }
//                }
//                .navigationTitle("Amotization Table")
//            
//                }.padding(25)
// 
//    }
//}
//
//struct SwiftUIView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        SavingAmotizationTable(presentValue: 100000, interestRate: 0.10, termInMonthsPlusOne: 36)
//    }
//}
