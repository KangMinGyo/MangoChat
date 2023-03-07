//
//  ChatLogViewModel.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/06.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    @Published var chatMessage = [ChatMessage]()
    @Published var emptyScrollToString = "Empty"
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    private func fetchMessages() {
        guard let fromID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toID = chatUser?.uid else { return }
        
        FirebaseManager.shared.fireStore
            .collection("messages")
            .document(fromID)
            .collection(toID)
            .order(by: "timeStamp")
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
                    self.errorMessage = "Failed to listen for messages: \(err)"
                    print(err)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessage.append(.init(documentID: change.document.documentID, data: data))
                    }
                })
                
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
    }
    
    func handleSend() {
        print(chatText)
        guard let fromID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toID = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.fireStore.collection("messages")
            .document(fromID)
            .collection(toID)
            .document()
        
        let messageData = [FirebaseConstants.fromID: fromID,
                           FirebaseConstants.toID: toID,
                           FirebaseConstants.text: self.chatText,
                           "timeStamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { err in
            if let err = err {
                self.errorMessage = "Failed to save message into Firestore: \(err)"
                return
            }
            print("Success send message")
            self.chatText = ""
            self.count += 1
        }
        
        let recipientMessageDocument = FirebaseManager.shared.fireStore.collection("messages")
            .document(toID)
            .collection(fromID)
            .document()
        
        recipientMessageDocument.setData(messageData) { err in
            if let err = err {
                print(err)
                self.errorMessage = "Failed to save message into Firestore: \(err)"
                return
            }
            print("Success saved message")
        }
    }
    
    @Published var count = 0
    
}

