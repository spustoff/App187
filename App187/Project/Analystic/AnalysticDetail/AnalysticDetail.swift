//
//  AnalysticDetail.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

struct AnalysticDetail: View {
    
    @State var isDetail: Bool = false
    
    let analystic: AnalysticModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Details")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.top, 31)
                    .padding(.bottom, 40)
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack {
                        
                        Text(analystic.smile)
                            .font(.system(size: 34, weight: .medium))
                        
                        Text("Month")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            .padding(.bottom, 25)
                        
                        Button(action: {
                            
                            isDetail = true
                            
                        }, label: {
                            
                            Image("chart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                        
                        VStack(alignment: .leading, content: {
                            
                            Text("Transactions")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            
                            VStack(spacing: 8, content: {
                                
                                Text("No Any Transactions")
                                    .foregroundColor(.white)
                                    .font(.system(size: 21, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                
                                Text("You don't have any transactions on this smile")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .multilineTextAlignment(.center)
                            })
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity, alignment: .center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isDetail, content: {
            
            ChartView()
        })
    }
}

struct AnalysticDetail_Previews: PreviewProvider {
    static var previews: some View {
        AnalysticDetail(analystic: AnalysticModel(smile: "🍓", title: "gdfg"))
    }
}
