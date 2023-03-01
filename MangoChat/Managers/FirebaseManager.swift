//
//  FirebaseManager.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/01.
//

import Foundation
import SwiftUI
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
}
