//
//  Calculations.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-29.
//

import Foundation

public class Calculation{
    
    static func calculateFutureValue(presentValue: Double, annualInterestRate: Double, noOfYears: Int) -> Double {
        let r = annualInterestRate
        let n = 12.0
        let t = Double(noOfYears)// Convert months to years
        
        let futureValue = presentValue * pow(1 + r / n, n * t)
        
        return futureValue
    }
    
    
    static func calculatePresentValue(futureValue: Double, annualInterestRate: Double, noOfYears: Int) -> Double {
        let r = annualInterestRate
        let n = 12.0// Monthly compounds
        let t = Double(noOfYears) // Convert months to years
        
        let presentValue = futureValue / pow(1 + r / n, n * t)
        
        return presentValue
    }
    
    static func calculateRequiredPeriodInMonths(presentValue: Double, futureValue: Double, annualInterestRate: Double) -> Double {
        let r = annualInterestRate
        let n = 12.0
        
        let a =  log(futureValue / presentValue)
        let b =   log(1 + (r/n)) * n
        
        let t = round((a / b))
        return t
    }
    
    
    static func calculateAnnualInterestRate(presentValue: Double, futureValue: Double, noOfYears: Int) -> Double {
        let n = 12.0
        let t = Double(noOfYears)
        
        let a = (1 / (n * t))
        let b = futureValue / presentValue
        let c = pow(b, a) - 1
        
        let rate = c * n
        
        return rate
    }

    
  static func calculateCompoundInterest(principal: Double, annualInterestRate: Double, years: Double) -> Double {
      let r = annualInterestRate
      let n = 12.0
      let t = years
      
      let compoundInterest = principal * pow(1 + r / n, n * t)
      
      return compoundInterest
  }
    
    
    
    static func calculateFutureValueOfSeriesEndOfThePeriod(paymentPerPeriod: Double, annualInterestRate: Double, years: Int) -> Double {
        let r = annualInterestRate
        let n = 12.0
        let t = Double(years)
        let pmt = paymentPerPeriod
        
        let futureValueOfSeries = pmt * (pow(1 + r / n, n * t) - 1) / (r / n)
        
        return futureValueOfSeries
    }
    
    static func calculateFutureValueOfSeriesBeginingOfThePeriod(paymentPerPeriod: Double, annualInterestRate: Double, years: Int) -> Double {
        
        let r = annualInterestRate
        let n = 12.0
        let t = Double(years)
        let pmt = paymentPerPeriod
        
        let futureValueOfSeries = pmt * ((pow(1 + r / n, n * t) - 1) / (r / n)) * (1 + r / n)
        
        return futureValueOfSeries
    }
    
    ///Mortgage
    static func calculateMonthlyMortgagePayment(principal: Double, annualInterestRate: Double, loanTermInYears: Int) -> Double {
        // Convert annual interest rate to monthly rate as a decimal
        let monthlyInterestRate = annualInterestRate / 12.0
        
        // Convert loan term from years to months
        let numberOfPayments = Double(loanTermInYears) * 12.0
        
        // Calculate the monthly mortgage payment
        let numerator = principal * monthlyInterestRate * pow(1.0 + monthlyInterestRate, numberOfPayments)
        let denominator = pow(1.0 + monthlyInterestRate, numberOfPayments) - 1.0
        
        let monthlyPayment = numerator / denominator
        return monthlyPayment
    }
    
    static func calculateMonthlyInterestRate(principal: Double, monthlyPayment: Double, loanTermInYears: Int) -> Double {
        
        
        let principal = principal
        let pmt = monthlyPayment
        let noOfPMT = Double(loanTermInYears) * 12.0
        
        return (1 - (1 / pow(1 + pmt / principal, noOfPMT / 12.0)))
        
    }
    
   static func calculateInterestRateIterativeMethod(principal: Double, monthlyPayment: Double, loanTermInYears: Int, isMonthlyInterestRate: Bool = true) -> Double? {
        // Convert loan term from years to months
        let numberOfPayments = Double(loanTermInYears) * 12.0
        
        // Initial guess for the interest rate (starting value for the iterative calculation)
        var interestRate = 0.05 // 5% (0.05 as a decimal)
        
        // Tolerance to stop the iterative calculation
        let tolerance = 0.0001
        
        // Maximum number of iterations to avoid infinite loop
        let maxIterations = 10000
        
        // Perform an iterative calculation using the Newton-Raphson method
        for _ in 1...maxIterations {
            let numerator = principal * interestRate * pow(1.0 + interestRate, numberOfPayments)
            let denominator = pow(1.0 + interestRate, numberOfPayments) - 1.0
            
            let calculatedMonthlyPayment = numerator / denominator
            
            if abs(calculatedMonthlyPayment - monthlyPayment) < tolerance {
                // Found a close enough approximation
                return isMonthlyInterestRate ? interestRate : interestRate * 12.0 // Return monthly or annual interest rate
            }
            
            let derivativeNumerator = (principal * pow(1.0 + interestRate, numberOfPayments - 1)) * (1.0 + numberOfPayments * interestRate)
            let derivativeDenominator = pow(1.0 + interestRate, numberOfPayments) - 1.0
            
            let derivative = derivativeNumerator / pow(derivativeDenominator, 2)
            
            interestRate -= (calculatedMonthlyPayment - monthlyPayment) / derivative
        }
        
        return nil // If the method doesn't converge, return nil
    }
  

    
    static func calculateLoanTermInYears(principal: Double, monthlyPayment: Double, annualInterestRate: Double) -> Int {
        // Calculate the loan term in years
        let monthlyInterestRate = annualInterestRate / 12
        let numerator = log(monthlyPayment / (monthlyPayment - principal * monthlyInterestRate))
        let denominator = log(1.0 + monthlyInterestRate)
        
        let loanTermInYears = (numerator / denominator) / 12.0 // Convert to years
        return Int(loanTermInYears)
    }
    
    static func calculateBorrowingAmount(monthlyPayment: Double, annualInterestRate: Double, loanTermInYears: Int) -> Double {
        // Convert loan term from years to months
    let numberOfPayments = Double(loanTermInYears) * 12.0
    let monthlyInterestRate = annualInterestRate / 12
    // Calculate the principal amount
    let numerator = monthlyPayment
    let denominator = monthlyInterestRate * pow(1.0 + monthlyInterestRate, numberOfPayments) / (pow(1.0 + monthlyInterestRate, numberOfPayments) - 1.0)
    
    let principalAmount = numerator / denominator
    return principalAmount
    }
    
    //END Mortgage
    
    static func calculatePresentValue(futureValue: Double, monthlyPayment: Double, monthlyInterestRate: Double, numberOfPayments: Int) -> Double {
        let numerator = monthlyPayment * (1.0 - pow(1.0 + monthlyInterestRate, -Double(numberOfPayments)))
        let denominator = monthlyInterestRate
        
        let presentValue = numerator / denominator
        
        return presentValue
    }

    static func calculatePresentValueOfAnnuity(
        futureValue: Double,
        annualInterestRate: Double,
        paymentAmount: Double,
        termInYears: Int,
        paymentMadeAtBegining: Bool) -> Double {
            
            var calculatedFutureValue = 0.00
        var seriesFV = 0.00
            
        if(paymentMadeAtBegining){
            seriesFV = calculateFutureValueOfSeriesBeginingOfThePeriod(paymentPerPeriod: paymentAmount, annualInterestRate: annualInterestRate, years: termInYears)
        }else{
            seriesFV = calculateFutureValueOfSeriesEndOfThePeriod(paymentPerPeriod: paymentAmount, annualInterestRate: annualInterestRate, years: termInYears)
        }
        
        calculatedFutureValue = futureValue - seriesFV
            
        return calculatePresentValue(futureValue: calculatedFutureValue, annualInterestRate: annualInterestRate, noOfYears: termInYears)
    }
    
    static func calculateFutureValueMonthly(presentValue: Double, annualInterestRate: Double, noOfYears: Int) -> Double {
        
        
        let r = (annualInterestRate) / 12
        let n = 1.0
        let t = Double(noOfYears)// Convert months to years
        if(t == 0){
            return presentValue
        }
        let futureValue = presentValue * pow(1 + r / n, n * t)
        
        return futureValue
    }
    
    
    
    ///Loan Related Calculation
    static func calculatePMT(annualInterestRate: Double, numberOfPaymentsPerYear: Double, principal: Double, totalNumberOfPayments: Double) -> Double {
        let interestRatePerPeriod = annualInterestRate / numberOfPaymentsPerYear
        let numerator = principal * interestRatePerPeriod * pow((1 + interestRatePerPeriod), totalNumberOfPayments)
        let denominator = pow((1 + interestRatePerPeriod), totalNumberOfPayments) - 1
        let pmt = numerator / denominator
        return pmt
    }

    static func calculateIPMT(principal: Double, annualInterestRate: Double, numberOfPaymentsPerYear: Double, period: Int, term: Int) -> Double {
        
        let r = annualInterestRate/numberOfPaymentsPerYear
        
        var nper = term - period
        if(nper == 0){
            nper = 1
        }
        
        let interestPortion = principal * r * pow((1+r),(Double(nper) - 1)) / pow((1+r),(Double(term) - 1))
        return interestPortion
    }
    
    static func calculatePPMT(principal: Double, annualInterestRate: Double, numberOfPaymentsPerYear: Double, period: Double, totalNumberOfPayments: Double) -> Double {
        let r = annualInterestRate / numberOfPaymentsPerYear
        let numerator = principal * r * pow((1 + r), (period - 1))
        let denominator = pow((1 + r), totalNumberOfPayments) - 1
        let pp = numerator / denominator
        return pp
    }
    
}
