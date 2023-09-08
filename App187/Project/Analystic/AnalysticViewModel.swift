//
//  AnalysticViewModel.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

final class AnalysticViewModel: ObservableObject {
    
    @Published var selected: AnalysticModel?
    @Published var isDetail: Bool = false
    @Published var analystics: [AnalysticModel] = [
    
        AnalysticModel(smile: "😊", title: "You spent $1000 with happiness"),
        AnalysticModel(smile: "😑", title: "You spent $100 in Ok mood"),
        AnalysticModel(smile: "😩", title: "You spent $100 with sadness"),
        AnalysticModel(smile: "💰", title: "Your income in August has grown"),
    ]
}
