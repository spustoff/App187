//
//  ChartView.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

struct ChartView: View {
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .bottom) {
                    
                    Text("$\(Int.random(in: 200...2555))")
                        .foregroundColor(.white)
                        .font(.system(size: 23, weight: .semibold))
                    
                    Spacer()
                    
                    Text("+\(Int.random(in: 1...25))%")
                        .foregroundColor(.green)
                        .font(.system(size: 14, weight: .regular))
                }
                .padding([.horizontal, .top])
                .padding(.top)
                
                Chart(pair: "EURUSD")
                    .disabled(true)
                
                Button(action: {
                    
                    router.wrappedValue.dismiss()
                    
                }, label: {
                    
                    Text("Done")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
