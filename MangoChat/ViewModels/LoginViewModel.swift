//
//  LoginViewModel.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/01.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var isLoginMode = false
    
    @Published var email = ""
    @Published var password = ""
    
    func handleAction() {
        if isLoginMode {
            print("~")
        } else {
            print("!")
        }
    }
}
