//
//  MainMessagesView.swift
//  MangoChat
//
//  Created by KangMingyo on 2023/03/02.
//

import SwiftUI

struct MainMessagesView: View {
    
    @EnvironmentObject private var viewModel: MainMessagesViewModel
    
    var body: some View {
        NavigationView {
            
            VStack {
                customNavBar
                messageView
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
            Image(systemName: "person.fill")
                .font(.system(size: 36, weight: .heavy))
            VStack(alignment: .leading, spacing: 4) {
                Text("UserName")
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
    }
    
    private var messageView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack{
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
    }
}
