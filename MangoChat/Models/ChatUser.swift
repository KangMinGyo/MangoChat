//
//  ChatUser.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/03.
//

import Foundation

struct ChatUser {
    let uid: String
    let email: String
    let profileImageURL: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}
