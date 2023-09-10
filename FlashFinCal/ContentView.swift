//
//  ContentView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            HomeScreen()
                .tabItem{
                    Label("Home", systemImage: "face.dashed.fill")
                }
            
            Text("Saving")
                .tabItem{
                    Label("Savings", systemImage: "trophy.circle.fill").font(.largeTitle)
                    
                }
                
            LoanView(loan: Loan())
                .tabItem{
                    Label("Loans", systemImage: "bolt.shield.fill")
                }
            
            Text("Mortgage")
                .tabItem{
                    Label("Mortgage", systemImage: "house.circle.fill")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
