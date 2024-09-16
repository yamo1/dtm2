//
//  RegisterEmail_code.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI
import Firebase

var userProfile = UserProfile(name: userName)

let userRef = Firestore.firestore().collection("users").document(userProfile.name)

@MainActor
struct RegisterEmailCodeView: View {
    
    @State private var isPresentingSheet = false
    
    // 本番で消す
    @State private var tmp = false
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ZStack {
                        if isData == true {
                            Text("Welcome back \(userName)")
                                .font(
                                    Font.custom("ModernEra-Medium", size: 12)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.16, green: 0.65, blue: 0.27))
                                .padding(.top, 56)
                                .padding(.bottom, 120)
                        }
                        // What's Your McGill Email?
                        Text("Check Your McGill\nEmail!")
                            .font(
                                Font.custom("New York", size: 28)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 256, alignment: .top)
                            .padding(.all, 0)
                            .onOpenURL { url in   // 2
                                let link = url.absoluteString
                                if Auth.auth().isSignIn(withEmailLink: link) {
                                    passwordlessSignIn(email: userName+"@town.biz", link: link) { result in    // 4
                                        switch result {
                                        case let .success(user):
                                            saveUserProfile(userProfile: userProfile)
                                            isPresentingSheet = user?.isEmailVerified ?? false
                                        case let .failure(error):
                                            isPresentingSheet = false
                                        }
                                    }
                                }
                            }
                            .padding(.top, 132)
                    }
                    
                }
                
                // Email
                Text("\(userName)@mail.mcgill.ca")
                    .font(
                        Font.custom("ModernEra-Medium", size: 16)
                            .weight(.bold)
                    )
                    .kerning(0.72)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 231, height: 11, alignment: .top)
                    .padding(.all, 0)
                    .padding(.top, 96)
                
                
                Image(systemName: "ellipsis")
                    .frame(width: 35, height: 5)
                    .padding(.top, 96)
                    .fullScreenCover(isPresented: $isPresentingSheet) {
                        MainTab()
                    }
                
                Button {
                    //sendSignInLink()
                    saveUserProfile(userProfile: userProfile)
                    tmp = true
                } label: {
                    Text("Resend")
                        .font(
                            Font.custom("ModernEra-Medium", size: 12)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                        .frame(alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 91)
                .fullScreenCover(isPresented: $tmp) {
                    MainTab()
                }
            }
            .padding(.trailing, 26)
            .padding(.leading, 26)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.all, 0)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    
    // checking authentication email function
    private func passwordlessSignIn(email: String, link: String,
                                    completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, link: link) { result, error in
            if let error = error {
                print("ⓧ Authentication error: \(error.localizedDescription).")
                completion(.failure(error))
            } else {
                print("✔ Authentication was successful.")
                completion(.success(result?.user))
            }
        }
    }
    
    // sending authentication email function
    private func sendSignInLink() {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(
            string: "https://dtm.page.link/enter"
        )
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        Auth.auth().sendSignInLink(toEmail: userName+"@town.biz",
                                   actionCodeSettings: actionCodeSettings) { error in   // will change to mcgill email
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}


#Preview {
    RegisterEmailCodeView()
}
