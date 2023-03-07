//
//  ChatLogView.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/04.
//

import SwiftUI

struct ChatLogView: View {
    
    @ObservedObject var viewModel: ChatLogViewModel
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.viewModel = .init(chatUser: chatUser)
    }
    
    var body: some View {
        ZStack {
            messagesView
            Text(viewModel.errorMessage)
            VStack {
                Spacer()
                chatBottomBar
                    .background(.white)
            }
        }
        .navigationTitle(chatUser?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
            .environmentObject(MainMessagesViewModel())
    }
}

extension ChatLogView {
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                TextField("Discription", text: $viewModel.chatText)
            }
            .frame(height: 40)
            
            Button {
                viewModel.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var messagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(viewModel.chatMessage) { message in
                        VStack {
                            if message.fromID == FirebaseManager.shared.auth.currentUser?.uid {
                                HStack {
                                    Spacer()
                                    HStack {
                                        Text(message.text)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(.blue)
                                    .cornerRadius(16)
                                }
                                .padding(.horizontal)
                                .padding(.top, 8)
                            } else {
                                HStack {
                                    HStack {
                                        Text(message.text)
                                            .foregroundColor(Color.black)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                    }
                    HStack { Spacer() }
                        .id(viewModel.emptyScrollToString)
                }
                .onReceive(viewModel.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(viewModel.emptyScrollToString, anchor: .bottom)
                    }
                }
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
    }
}
