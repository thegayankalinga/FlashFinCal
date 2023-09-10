//
//  LoanModel.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-09-10.
//

import Foundation


class Loan : ObservableObject{
    
    var borrowingAmount: Double?
    var annualInterestRate: Double?
    var termInMonths: Int?
    var paymentsPerYear: Int?
    var installmentAmount: Double?
    var paymentMadeAtEnd: Bool = false
    var interestSubsidicedPercentage: Double?
    var paymentStartDate: Date = Date.now
    
    init(borrowedAmount: Double, annualInterestRate: Double, termInMonths: Int, paymentsPerYear: Int, installmentAmount: Double, paymentMadeAtEnd: Bool, interestSubsidicedPercentage: Double, paymentStartDate: Date) {
        self.borrowingAmount = borrowedAmount
        self.annualInterestRate = annualInterestRate
        self.termInMonths = termInMonths
        self.paymentsPerYear = paymentsPerYear
        self.installmentAmount = installmentAmount
        self.paymentMadeAtEnd = paymentMadeAtEnd
        self.interestSubsidicedPercentage = interestSubsidicedPercentage
        self.paymentStartDate = paymentStartDate
    }
    
    init(){
        
    }
 
}
