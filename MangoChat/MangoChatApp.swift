//
//  MangoChatApp.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/01.
//

import SwiftUI

@main
struct MangoChatApp: App {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
