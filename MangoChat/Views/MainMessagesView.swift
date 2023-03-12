//
//  MainMessagesView.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainMessagesView: View {
    
    @State var chatUser: ChatUser?
    @EnvironmentObject private var viewModel: MainMessagesViewModel
    
    var body: some View {
        NavigationView {
            
            VStack {
                customNavBar
                messageView
                
                NavigationLink("", isActive: $viewModel.shouldNavigateToChatLogView) {
                    ChatLogView(chatUser: self.chatUser)
                        .environmentObject(ChatLogViewModel(chatUser: viewModel.chatUser))
                }
            }
            .overlay(
                newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
            .environmentObject(MainMessagesViewModel())
        
        MainMessagesView()
            .environmentObject(MainMessagesViewModel())
            .preferredColorScheme(.dark)
    }
}

extension MainMessagesView {
    
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: viewModel.chatUser?.profileImageURL ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipped()
                .cornerRadius(22)
                .shadow(radius: 5)
                .overlay(RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.gray, lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                let email = viewModel.chatUser?.email.components(separatedBy: "@").first ?? ""
                Text("\(email)")
                    .font(.system(size: 24, weight: .bold))
                HStack(spacing:4) {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 7, height: 7)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
            Button {
                viewModel.shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .confirmationDialog("Setting", isPresented: $viewModel.shouldShowLogOutOptions, actions: {
            Button(role: .destructive) {
                viewModel.signOut()
                print("Sign Out")
            } label: {
                Text("Sign Out")
            }
            
            Button(role: .cancel) {
                
            } label: {
                Text("Cancel")
            }
        }, message: {
            Text("What do you want to do?")
        })
        .fullScreenCover(isPresented: $viewModel.isUserCurrentlyLoggedOut) {
            LoginView()
                .environmentObject(LoginViewModel(didCompleteLoginProcess: {
                    self.viewModel.isUserCurrentlyLoggedOut = false
                    self.viewModel.fetchCurrentUser()
                    self.viewModel.fetchRecentMessages()
                }))
        }
    }
    
    private var messageView: some View {
        ScrollView {
            ForEach(viewModel.recentMessages) { recentMessage in
                VStack{
                    Button {
                        let uid = FirebaseManager.shared.auth.currentUser?.uid == recentMessage.fromID ? recentMessage.toID : recentMessage.fromID
                        self.chatUser = .init(data: [FirebaseConstants.email: recentMessage.email, FirebaseConstants.profileImageURL: recentMessage.profileImageURL, FirebaseConstants.uid: uid])
                        viewModel.shouldNavigateToChatLogView.toggle()
                    } label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: recentMessage.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(25)
                                .shadow(radius: 5)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray, lineWidth: 1))
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.userName)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.darkGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Text(recentMessage.time)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(UIColor.systemGray))
                        }
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 50)
    }
    
    private var newMessageButton: some View {
        Button {
            viewModel.shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.accentColor)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 10)
        }
        .fullScreenCover(isPresented: $viewModel.shouldShowNewMessageScreen) {
            NewMessageView()
                .environmentObject(NewMessageViewModel(didSelectNewUser: { user in
                    print("fullScreen: \(user.email)")
                    self.viewModel.shouldNavigateToChatLogView.toggle()
                    self.chatUser = user
                }))
        }
    }
}
