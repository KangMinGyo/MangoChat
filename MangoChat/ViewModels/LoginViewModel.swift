//
//  LoginViewModel.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/01.
//

import Foundation
import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var isLoginMode = false
    @Published var email = ""
    @Published var password = ""
    @Published var loginStatusMessage = ""

    func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            creatNewAccount()
        }
    }
    
    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to cerate user: \(err)"
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    func creatNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                print("Failed to cerate user:", err)
                self.loginStatusMessage = "Failed to cerate user: \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
}
