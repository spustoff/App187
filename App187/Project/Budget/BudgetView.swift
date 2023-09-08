//
//  BudgetView.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

struct BudgetView: View {
    
    @StateObject var viewModel = BudgetViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("budget_gradient")
                    .frame(height: 270)
                    .cornerRadius(10)
                    .overlay (
                    
                        VStack {
                            
                            ZStack {
                                
                                Text("Budget")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .medium))
                            }
                            
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 15, content: {
                                    
                                    HStack(content:  {
                                        
                                        Text("$0")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15, weight: .medium))
                                        
                                        Text("0% done")
                                            .foregroundColor(.black)
                                            .font(.system(size: 13, weight: .regular))
                                    })
                                    
                                    Text("Visa 0001")
                                        .foregroundColor(.black)
                                        .font(.system(size: 21, weight: .regular))
                                    
                                    Text("$\(viewModel.budgets.map(\.sum).reduce(0, +))")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isAddTransaction = true
                                    }
                                    
                                }, label: {
                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .font(.system(size: 23, weight: .semibold))
                                })
                            }
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                            .padding()
                            .padding(.top, 50)
                    )
                
                VStack(alignment: .leading, content: {
                    
                    Text("Transactions")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                    
                    if viewModel.budgets.isEmpty {
                        
                        VStack(spacing: 8, content: {
                            
                            Image("card_empty")
                            
                            Text("No Transactions")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .multilineTextAlignment(.center)
                            
                            Text("All your transactions wil be here")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.center)
                        })
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.budgets, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        Text(index.title ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text("$\(index.sum)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                }
                            }
                        }
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            
            viewModel.fetchBudgets()
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isAddTransaction ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTransaction = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.addTrans(completion: {
                                
                                viewModel.sum = ""
                                
                                viewModel.fetchBudgets()
                            })
                            
                            UIApplication.shared.endEditing()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddTransaction = false
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .opacity(viewModel.sum.isEmpty || viewModel.title.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.sum.isEmpty || viewModel.title.isEmpty ? true : false)
                    }
                    .padding(.bottom)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("$ 1.500")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.sum.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.sum)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    .padding(.bottom, 40)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Title")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.title.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.title)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                }
                .padding()
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("bg").ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isAddTransaction ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}
