//
//  SettingsView.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.vertical)
                
                Button(action: {
                    
                    guard let url = URL(string: "https://docs.google.com/document/d/1tUQdNlWNLLSkxA_uYXIZ4SdcMprwdC91twuw_nlOTQQ/edit") else { return }
                    
                    UIApplication.shared.open(url)
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "doc")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        Text("Usage Policy")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    .padding(.horizontal)
                })
                
                Button(action: {
                    
                    SKStoreReviewController.requestReview()
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "star")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        Text("Rate Us")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    .padding(.horizontal)
                })
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
