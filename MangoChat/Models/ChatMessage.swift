//
//  ChatMessage.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/06.
//

import Foundation
import Firebase

struct ChatMessage: Identifiable {
    
    var id: String { documentID }
    
    let documentID: String
    let fromID: String
    let toID: String
    let text: String
    let email: String
    let timestamp: Timestamp
    let profileImageURL: String
    
    init(documentID: String, data: [String: Any]) {
        self.documentID = documentID
        self.fromID = data[FirebaseConstants.fromID] as? String ?? ""
        self.toID = data[FirebaseConstants.toID] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.timestamp = data[FirebaseConstants.timestamp] as? Timestamp ?? Timestamp(date: Date())
        self.profileImageURL = data[FirebaseConstants.profileImageURL] as? String ?? ""
        self.email = data[FirebaseConstants.email] as? String ?? ""
    }
}

struct FirebaseConstants {
    static let fromID = "fromID"
    static let toID = "toID"
    static let text = "text"
    static let email = "email"
    static let timestamp = "timestamp"
    static let profileImageURL = "profileImageURL"
    
}
