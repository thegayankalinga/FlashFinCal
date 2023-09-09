//
//  HelpView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    var helpString: String = ""
    var fromScreen: String = ""
    var body: some View {
        
        
        NavigationStack {
            VStack(alignment: .leading) {
                    Text("Readon on about \(fromScreen)")
                    Divider()
                    ScrollView {
                        Text(helpString)
                            .font(.title3)
                        
                        
                    }
                
                
            }.padding(30)
                .navigationTitle("Help")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Press to dismiss") {
                                    dismiss()
                                }
                    }
            })
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
