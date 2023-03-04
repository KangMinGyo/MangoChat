//
//  NewMessageViewModel.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/03.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    @Published var didSelectNewUser: (ChatUser) -> ()
    
    init(didSelectNewUser: @escaping (ChatUser) -> Void) {
        self.didSelectNewUser = didSelectNewUser
        fetchAllUsers()
    }
//    init() {
//        fetchAllUsers()
//    }
    
    private func fetchAllUsers() {
        FirebaseManager.shared.fireStore.collection("users")
            .getDocuments { documentSnapshot, err in
                if let err = err {
                    self.errorMessage = "유저를 불러오는데 실패하였습니다. : \(err)"
                    print("유저를 불러오는데 실패하였습니다. : \(err)")
                    return
                }
                
                documentSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let user = ChatUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                })
            }
    }
}
