//
//  RegisterEmailView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import UIKit

var userName = ""

var isData = false

struct RegisterEmailView: View {
    // Registe Email
    @State var inputEmail = ""
    @State private var isInput = false
    
    @FocusState private var focusNow:Bool
    
    @State private var alertItem: AlertItem? = nil
    @State private var isPresentingSheet = false
    
    @State private var isError = false
    
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading) {
                    Button() {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 12)
                    
                    ZStack {
                        if (isError) {
                            Text("Oops email not found")
                                .font(
                                    Font.custom("ModernEra-Medium", size: 12)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 1, green: 0.75, blue: 0.03))
                                .padding(.top, 32)
                                .padding(.bottom, 121)
                        }
                        
                        // What's Your McGill Email?
                        Text("What’s Your McGill\nEmail?")
                            .font(
                                Font.custom("New York", size: 28)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(width: 319, height: 72, alignment: .topLeading)
                            .padding(.top, 103)
                    }
                    
                    // inputForm
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            TextField("firstname.lastname", text: $inputEmail, onCommit: {
                                if !inputEmail.isEmpty {
                                    isInput = true
                                    userName = inputEmail
                                    sendSignInLink()
                                    checkDocumentExists()
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .keyboardType(.emailAddress)
                            .padding(.bottom, 5)
                            .focused($focusNow)
                            
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(height: 1, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onAppear() {
                            DispatchQueue.main.async {
                                focusNow = true
                            }
                        }
                        .navigationDestination(isPresented: $isInput) {
                            RegisterEmailCodeView()
                        }
                        
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            Text("@mail.mcgill.ca")
                                .font(
                                    Font.custom("ModernEra-Medium", size: 18)
                                )
                                .padding(.bottom, 5)
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(width: 130, height: 1, alignment: .leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 51) // 自動で5px空いてしまうため、-5した
                    
                    // info
                    Text("We’ll send a confirmation link to verify you’re a McGill Student")
                        .font(
                            Font.custom("ModernEra-Medium", size: 12)
                                .weight(.medium)
                        )
                    
                        .foregroundColor(.gray)
                        .frame(width: 251, alignment: .topLeading)
                        .padding(.top, 12)
                    
                    Spacer()
                    
                }
                
                // Next
                NavigationLink {
                    RegisterEmailCodeView()
                } label: {
                    Text("Next")
                        .font(
                            Font.custom("ModernEra-Medium", size: 18)
                        )
                        .bold()
                        .frame(width: 54, alignment: .top)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(inputEmail.isEmpty ? AnyView(Constants.PlaceholderGrey) : AnyView(LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )))
                        .cornerRadius(33)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                }
                .disabled(inputEmail.isEmpty)
                .frame(width: 85, height: 52, alignment: .trailing)
                .simultaneousGesture(TapGesture().onEnded {
                    // 実行させたい処理を記載
                    userName = inputEmail
                    checkDocumentExists()
                    // sendSignInLink()
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 4)
                
                Spacer()
                
                
            }
            .frame(maxWidth: .infinity)
            
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
    }
    
    // sending authentication email function
    func sendSignInLink() {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(
            string: "https://dtm.page.link/enter"
        )
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        Auth.auth().sendSignInLink(toEmail: inputEmail+"@town.biz",
                                   actionCodeSettings: actionCodeSettings) { error in   // will change to mcgill email
            if let error = error {
                isError = true
            }
        }
    }
    
    // check is document exited or not
    func checkDocumentExists() {
        Firestore.firestore().collection("users").document("\(userName)").getDocument { (document, error) in
            if let document = document, document.exists {
                isData = true
                print("exist")
            } else {
                isData = false
                print("not exist")
            }
        }
    }
}

#Preview {
    RegisterEmailView()
}

struct AlertItem: Identifiable {    // *
    var id = UUID()
    var title: String
    var message: String
}
