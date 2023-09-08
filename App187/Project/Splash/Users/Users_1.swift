//
//  Users_1.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

struct Users_1: View {
    
    let telegram: URL
    let isTelegram: Bool
    let isContacts: Bool
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("users_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(spacing: 8, content: {
                    
                    Text("Invest, Grow, Succeed")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Explore the forex with us")
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .padding(.top)
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    Users_2(telegram: telegram, isTelegram: isTelegram, isContacts: isContacts)
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct Users_1_Previews: PreviewProvider {
    static var previews: some View {
        Users_1(telegram: URL(string: "h")!, isTelegram: false, isContacts: false)
    }
}
