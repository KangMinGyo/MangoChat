//
//  MangoChatApp.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/01.
//

import SwiftUI
//import FirebaseCore

@main
struct MangoChatApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
