//
//  EndEditing.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
