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
    @Binding var showInfoCard: Bool
    
    let card: Card

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(AppCustomColors.lightBlue)
                    .shadow(radius: 8)
                
                
                
                HStack {
                    Image(systemName: card.icon)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue)
                        .font(.system(size: 24))
                    
                    VStack{
                        HStack (alignment: .top){
                            Text(card.text)
                                .font(.callout)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                            Button{
                                print("close card button clicked")
                                showInfoCard.toggle()
                            }label: {
                                Text("X")
                            }
                        }
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(height: 30)
            
        }
}

struct InforCardView_Previews: PreviewProvider {
    static var previews: some View {
        InforCardView(showInfoCard: .constant(true), card: Card.example)
    }
}
