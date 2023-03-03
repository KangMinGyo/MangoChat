//
//  MainMessagesViewModel.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/02.
//

import Foundation
import SwiftUI

class MainMessagesViewModel: ObservableObject {
    
    @Published var shouldShowLogOutOptions = false
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else {
            self.errorMessage = "Could not find firebase uid"
            return
            
        }
        
//        self.errorMessage = "\(uid)"
        FirebaseManager.shared.fireStore.collection("users").document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                
                guard let data = snapshot?.data() else { return }

                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let profileImageURL = data["profileImageURL"] as? String ?? ""

                self.chatUser = ChatUser(uid: uid, email: email, profileImageURL: profileImageURL)
                
//                self.errorMessage = chatUser.profileImageURL
        }
    }
}
