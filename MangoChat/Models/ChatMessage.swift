//
//  ChatMessage.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/06.
//

import Foundation

struct ChatMessage: Identifiable {
    
    var id: String { documentID }
    
    let documentID: String
    let fromID: String
    let toID: String
    let text: String
    
    init(documentID: String, data: [String: Any]) {
        self.documentID = documentID
        self.fromID = data[FirebaseConstants.fromID] as? String ?? ""
        self.toID = data[FirebaseConstants.toID] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
}

struct FirebaseConstants {
    static let fromID = "fromID"
    static let toID = "toID"
    static let text = "text"
    
}