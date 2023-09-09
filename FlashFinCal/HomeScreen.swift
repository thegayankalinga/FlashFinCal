//
//  ViewOne.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-23.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            
            if(colorScheme == .dark){
                Image("background_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all
                    )
            }else if(colorScheme == .light){
                Image("background_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all
                    )
            }
            
      
                
            VStack {
                VStack(){
                        
                        Text("Welcome to Flash Fin Cal")
                            .font(.title)
                            .foregroundStyle(colorScheme == .light ? Color.black : Color.black)
                        Divider()
                        Spacer()
                    }
                .padding(.top, 100)
                Spacer()
                VStack{
                    Text("Enjoy hassle free decision making...")
                        .foregroundStyle(colorScheme == .light ? Color.black : Color.black)
                    
                }
                .padding(.bottom, 100)
            }

            
           
        }
    }
}

struct ViewOne_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
