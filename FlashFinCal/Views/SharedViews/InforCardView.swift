//
//  InforCardView.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-09-10.
//

import SwiftUI

struct Card {
    let icon: String
    let text: String

    static let example = Card(icon: "info.circle", text: "This is a text that will be shown in the card")
}

struct InforCardView: View {
    let card: Card

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(AppCustomColors.lightYellow)
                    .shadow(radius: 10)
                
                

                HStack {
                    Image(systemName: card.icon)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue)
                        .font(.system(size: 24))
                    
                    Text(card.text)
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(height: 30)
            
        }
}

struct InforCardView_Previews: PreviewProvider {
    static var previews: some View {
        InforCardView(card: Card.example)
    }
}
