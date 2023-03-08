//
//  RecentMessage.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/08.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    
//    var id: String { documentID }
    @DocumentID var id: String?
    
//    let documentID: String
    let text: String
    let fromID, toID: String
    let email, profileImageURL: String
//    let timestamp: Timestamp
    
//    init(documentID: String, data: [String: Any]) {
//        self.documentID = documentID
//        self.text = data["text"] as? String ?? ""
//        self.email = data["email"] as? String ?? ""
//        self.fromID = data["fromID"] as? String ?? ""
//        self.toID = data["toID"] as? String ?? ""
//        self.profileImageURL = data["profileImageURL"] as? String ?? ""
        //        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
//    }
}
