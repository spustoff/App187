//
//  AnalysticView.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

struct AnalysticView: View {
    
    @StateObject var viewModel = AnalysticViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Analystic")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.top)
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            Text("🎠")
                                .font(.system(size: 32, weight: .semibold))
                            
                            Text("We recommend spending no more than 30% of your income on entertainment")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        .padding([.horizontal, .top])
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.analystics) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selected = index
                                    viewModel.isDetail = true
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 45, content: {
                                        
                                        Text(index.smile)
                                            .font(.system(size: 19, weight: .medium))
                                        
                                        Text(index.title)
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .medium))
                                            .multilineTextAlignment(.leading)
                                    })
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                })
                            }
                        })
                        .padding(.horizontal)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            if let index = viewModel.selected {
                
                AnalysticDetail(analystic: index)
            }
        })
    }
}

struct AnalysticView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysticView()
    }
}
