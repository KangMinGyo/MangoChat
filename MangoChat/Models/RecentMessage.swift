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
    
    @DocumentID var id: String?
    let text: String
    let fromID, toID: String
    let email, profileImageURL: String
    let timestamp: Date
}
