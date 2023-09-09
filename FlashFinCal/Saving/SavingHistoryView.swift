//
//  HistoryView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct SavingHistoryView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var savingCalculations: FetchedResults<SavingEntity>
    
    func removeSavingItem(at offsets: IndexSet) {
        
//        @FetchRequest(sortDescriptors: []) var savingCalculations: FetchedResults<SavingEntity>
//
        for index in offsets {
            let record = savingCalculations[index]
            moc.delete(record)
        }
        do {
            try moc.save()
        } catch {
            // handle the Core Data error
        }
    }
    
    var body: some View {
         
            VStack {
                List {
                    ForEach(savingCalculations){ calculation  in

 
                            if(calculation.termInYears != 0){
                                NavigationLink{ SavingAmotizationTable(
                                    presentValue:calculation.presentValue ,
                                    interestRate: calculation.interestRate,
                                    termInMonthsPlusOne: Int((calculation.termInYears * 12) + 1))
                                }label: {
                                    VStack(alignment: .leading){
                                        Text("Invest Amount: \(calculation.presentValue, specifier: "%.2f")")
                                            .foregroundColor(.primary)
                                        
                                        Text("Term (Y): \(calculation.termInYears, specifier: "%.2f")")
                                            .foregroundColor(.secondary)
                                                        .font(.subheadline)
                                        
                                        Text("Int Rate : \(calculation.interestRate.formatted(.percent))")
                                            .foregroundColor(.secondary)
                                                        .font(.subheadline)
                                    }
                                }
                            }
                            
                        
                    }.onDelete(perform: removeSavingItem)
                }
                
                .navigationTitle("History")
            
            
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SavingHistoryView()
    }
}
