//
//  LoginView.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/01.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var viewModel: LoginViewModel
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 16){
                    picker
                    
                    if !viewModel.isLoginMode {
                        imageButton
                    }
                    
                    group
                        .padding(12)
                        .background(.white)
                    
                    loginButton
                }
                .padding()
            }
            .navigationTitle(viewModel.isLoginMode ? "로그인" : "회원가입")
            .background(Color(.init(white: 0, alpha: 0.03))
                .ignoresSafeArea())
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}

extension LoginView {
    private var picker: some View {
        Picker(selection: $viewModel.isLoginMode) {
            Text("로그인")
                .tag(true)
            Text("회원가입")
                .tag(false)
        } label: {
            Text("Picker Here")
        } .pickerStyle(.segmented)
    }
    
    private var imageButton: some View {
        
        Button {
            
        } label: {
            Image(systemName: "person.fill")
                .font(.system(size: 64))
                .padding()
        }
    }
    
    private var group: some View {
        Group {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            SecureField("Password", text: $viewModel.password)
        }
    }
    
    private var loginButton: some View {
        Button {
            viewModel.handleAction()
        } label: {
            HStack {
                Spacer()
                Text(viewModel.isLoginMode ? "로그인" : "회원가입")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
            }.background(Color.accentColor)
        }

    }
}
