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
                
                Saving()
                    .tabItem{
                        Label("Savings", systemImage: "trophy.circle.fill").font(.largeTitle)
                        
                    }
                    
                Loan()
                    .tabItem{
                        Label("Loans", systemImage: "bolt.shield.fill")
                    }
                
                Mortgage()
                    .tabItem{
                        Label("Mortgage", systemImage: "house.circle.fill")
                    }
                
            }
            .navigationTitle("Flash FinCal")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        //NavigationLink("Help", destination: HistoryView())
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(.title2))
                        
                    }
                }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
