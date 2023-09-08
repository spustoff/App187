//
//  GoalsView.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

struct GoalsView: View {
    
    @StateObject var viewModel = GoalsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("goal_gradient")
                    .frame(height: 270)
                    .cornerRadius(10)
                    .overlay (
                    
                        VStack {
                            
                            ZStack {
                                
                                Text("Goals")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .medium))
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        withAnimation(.spring()) {
                                            
                                            viewModel.isAddGoal = true
                                        }
                                        
                                    }, label: {
                                        
                                        Image(systemName: "plus")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .semibold))
                                    })
                                }
                            }
                            
                            if viewModel.goals.isEmpty {
                                
                                HStack {
                                    
                                    Text("Add First Goal")
                                        .foregroundColor(.black)
                                        .font(.system(size: 21, weight: .regular))
                                    
                                    Spacer()
                                }
                                .padding(.top, 50)
                                
                            } else {
                                
                                TabView(content: {
                                    
                                    ForEach(viewModel.goals, id: \.self) { index in
                                        
                                        HStack {
                                            
                                            VStack(alignment: .leading, spacing: 15, content: {
                                                
                                                HStack(content:  {
                                                    
                                                    Text("$\(index.goalAmount)")
                                                        .foregroundColor(.black)
                                                        .font(.system(size: 15, weight: .medium))
                                                    
                                                    Text("0% done")
                                                        .foregroundColor(.black)
                                                        .font(.system(size: 13, weight: .regular))
                                                })
                                                
                                                Text(index.title ?? "")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 21, weight: .regular))
                                                
                                                Text("$\(index.currentAmount)")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 16, weight: .medium))
                                            })
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedGoalForTrans = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isAddTrans = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "plus")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 23, weight: .semibold))
                                            })
                                        }
                                        .padding(.top, 50)
                                    }
                                })
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            }
                            
                            Spacer()
                        }
                            .padding()
                            .padding(.top, 50)
                    )
                
                HStack {
                    
                    Text("☕️")
                        .font(.system(size: 32, weight: .semibold))
                    
                    Text("If you cut back to 1 cup of coffee a day, you can save $200 a month")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                    
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                .padding([.horizontal, .top])
                
                Image("empty")
                    .padding(.top, 50)
                
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isAddTrans ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTrans = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            if let index = viewModel.selectedGoalForTrans {
                                
                                viewModel.addTransaction(for: index, completion: {
                                    
                                    viewModel.fetchGoals()
                                })
                            }
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddTrans = false
                            }
                            
                            UIApplication.shared.endEditing()
                            
                            viewModel.transAmount = ""
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .opacity(viewModel.transAmount.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.transAmount.isEmpty ? true : false)
                    }
                    .padding(.bottom)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("$ 1.500")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.transAmount.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.transAmount)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    HStack {
                        
                        ForEach(viewModel.amounts, id: \.self) { index in
                            
                            Text("$\(index)")
                                .foregroundColor(viewModel.transAmount == index ? .white : .black)
                                .font(.system(size: 13, weight: .medium))
                                .frame(height: 40)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.transAmount == index ? Color("primary") : Color.white))
                                .onTapGesture {
                                    
                                    viewModel.transAmount = index
                                }
                        }
                    }
                }
                .padding()
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("bg").ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isAddTrans ? 0 : UIScreen.main.bounds.height)
            }
        )
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isAddGoal ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddGoal = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Text("New Goal")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.addGoals(completion: {
                                
                                viewModel.fetchGoals()
                            })
                            
                            viewModel.goalAmount = ""
                            viewModel.title = ""
                            
                            UIApplication.shared.endEditing()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddGoal = false
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .opacity(viewModel.goalAmount.isEmpty || viewModel.title.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.goalAmount.isEmpty || viewModel.title.isEmpty ? true : false)
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Goal")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("$ 1.500")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.goalAmount.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.goalAmount)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .keyboardType(.decimalPad)
                        })
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Title")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Gucci B")
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
                }
                .padding()
                .padding(.vertical)
                .padding(.bottom, 80)
                .frame(maxWidth: .infinity)
                .background(Color("bg").ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isAddGoal ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchGoals()
        }
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
