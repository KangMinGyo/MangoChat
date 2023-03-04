//
//  NewMessageView.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/03.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageView: View {
    
    @EnvironmentObject private var viewModel: NewMessageViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                //Text(viewModel.errorMessage)
                userProfiles
            }
            .navigationTitle("새로운 메시지")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView()
            .environmentObject(NewMessageViewModel(didSelectNewUser: { user in
                print(user.email)
            }))
//        MainMessagesView()
//            .environmentObject(MainMessagesViewModel())
    }
}

extension NewMessageView {
    
    private var userProfiles: some View {
        ForEach(viewModel.users) { user in
            Button {
                presentationMode.wrappedValue.dismiss()
                viewModel.didSelectNewUser(user)
            } label: {
                HStack(spacing: 16){
                    WebImage(url: URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipped()
                        .cornerRadius(22)
                        .overlay(RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.gray, lineWidth: 1))
                    Text(user.email)
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.horizontal)
                Divider()
            }
        }
        
    }
}
