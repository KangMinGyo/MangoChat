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
                let email = viewModel.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
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
                }))
        }
    }
    
    private var messageView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack{
                    NavigationLink {
                        Text("Destination\(num)")
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1))
                            VStack(alignment: .leading) {
                                Text("UserName")
                                    .font(.system(size: 16, weight: .bold))
                                Text("Message sent to user")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                            }
                            Spacer()
                            Text("22d") //시간
                                .font(.system(size: 14, weight: .semibold))
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
                    print(user.email)
                    self.viewModel.shouldNavigateToChatLogView.toggle()
                    self.chatUser = user // ?
                }))
        }
    }
}
