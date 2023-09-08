//
//  Users_2.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI
import StoreKit

struct Users_2: View {
    
    let telegram: URL
    let isTelegram: Bool
    let isContacts: Bool
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("users_2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(spacing: 8, content: {
                    
                    Text("Share your experience")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Rate us in the App Store")
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .padding(.top)
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    if isTelegram == true {
                        
                        Users_3(telegram: telegram, isTelegram: isTelegram, isContacts: isContacts)
                            .navigationBarBackButtonHidden()
                        
                    } else if isTelegram == false {
                        
                        if isContacts == true {
                            
                            Users_4()
                                .navigationBarBackButtonHidden()
                            
                        } else if isContacts == false {
                            
                            Users_5()
                                .navigationBarBackButtonHidden()
                        }
                    }
                    
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
        .onAppear {
            
            SKStoreReviewController.requestReview()
        }
    }
}

struct Users_2_Previews: PreviewProvider {
    static var previews: some View {
        Users_2(telegram: URL(string: "h")!, isTelegram: false, isContacts: false)
    }
}
