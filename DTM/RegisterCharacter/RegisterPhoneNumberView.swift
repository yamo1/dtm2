//
//  RegisterPhoneNumberView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

var nnn: String = ""
var sentCode: String?

struct RegisterPhoneNumberView: View {
    @State var inputNumber = ""
    @State private var isInput = false
    @State var nation = "🇨🇦+1"
    
    @State var isNation = false
    
    @FocusState private var focusNow:Bool
    
    @State var nationCode = ""
    
    @State private var isLoading: Bool = true
    
    var now = 0
    
    public var body: some View {
        NavigationStack {
            VStack {
                Text("Complete later")
                    .font(
                        Font.custom("ModernEra-Medium", size: 12)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 32)
                    .padding(.top, 16)
                
                // Line
                VStack(spacing: 0) {
                    ZStack {
                        HStack {
                            ForEach(1...10, id:\.self) { number in
                                Spacer()
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 25, height: 5)
                                    .background(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color.clear)
                                    .cornerRadius(5)
                            }
                            Spacer()
                        }
                        HStack {
                            ForEach(1...11, id:\.self) { number in
                                Image(systemName: number <= now ? "circle.fill" : "circle")
                                    .frame(width: 15, height: 15)
                                    .background(Color.white)
                                    .foregroundColor(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                                if number != 11 {
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .frame(width: 329, height: 15)
                .padding(.top, 48)
                .padding(.trailing, 32)
                .padding(.leading, 32)
                
                // Number
                VStack(alignment: .leading, spacing: 0) {
                    // What's Your McGill Email?
                    Text("What’s Your Number?")
                        .font(
                            Font.custom("New York", size: 28)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .padding(.top, 60)
            
                    // inputForm
                    HStack {
                        VStack(spacing: 0) {
                            Button {
                                isNation.toggle()
                            } label: {
                                ZStack {
                                    Text("\(String(nation.split(separator: "+")[0]))")
                                        .frame(height: 22)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("+\(String(nation.split(separator: "+")[1]))")
                                        .frame(height: 22)
                                        .padding(.leading, 30)
                                }
                                    
                                Image(systemName: "chevron.down")
                                    .frame(width: 8, height: 4, alignment: .trailing)
                                    .font(
                                        Font.custom("ModernEra-Medium", size: 12)
                                    )
                                    .padding(.leading, 5)
                            }
                            .sheet(isPresented: $isNation) {
                                PhoneGlobalCode(nations: $nation)
                            }
                            .font(
                                Font.custom("ModernEra-Medium", size: 24)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(width: 94, alignment: .leading)
                            .padding(.top, 5)
                            .padding(.bottom, 11)
                            
                            
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(width: 94, height: 1, alignment: .leading)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            TextField("", text: $inputNumber, onCommit: {
                                if !inputNumber.isEmpty {
                                    isInput = true
                                }

                            })
                            // .multilineTextAlignment(.trailing)
                            .font(
                                Font.custom("ModernEra-Medium", size: 24)
                                    .weight(.bold)
                            )
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .keyboardType(.numberPad)
                            .padding(.bottom, 7)
                            .padding(.leading, 16)
                            .focused($focusNow)
                            
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(width: 197, height: 1)
                            
                        }
                        .onAppear() {
                            DispatchQueue.main.async {
                                focusNow = true
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 72)
                    
                    // info
                    Text("We’ll send you a verification code. Your date will see it 5 mins before meeting you.")
                        .font(
                            Font.custom("ModernEra-Medium", size: 12)
                                .weight(.medium)
                        )
                        .foregroundColor(.gray)
                        .padding(.top, 16)
                    
                    Spacer()
                    // Next
                    NavigationLink {
                        RegisterPhoneCodeView()
                    } label: {
                        Text("Next")
                            .font(
                                Font.custom("ModernEra-Medium", size: 16)
                            )
                            .bold()
                            .frame(width: 54, height: 22, alignment: .center)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 15)
                            .foregroundColor(Color.white)
                            .background(inputNumber.isEmpty ? AnyView(Constants.disableGrey) : AnyView(LinearGradient(
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
                    .disabled(inputNumber.isEmpty)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .simultaneousGesture(TapGesture().onEnded {
                        // 実行させたい処理を記載
                        if nation != "nation" {
                            nationCode = "+"+String(nation.split(separator: "+")[1])
                            print(nationCode+inputNumber.removingFirstCharacter())
                        }
                        updateProfile(segment: "number", value: nationCode+inputNumber.removingFirstCharacter())
                        sendVerificationCode()
                    })
                    .padding(.bottom, 60)
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                
                VStack {
                    if isLoading {
                        Text("Loading...")
                    } else if let user = user {
                        Text("Logged in as \(user.email ?? "Unknown")")
                    } else {
                        Text("Not logged in")
                    }
                }
                .onAppear {
                    handle = Auth.auth().addStateDidChangeListener { auth, user1 in
                        user = user1
                        self.isLoading = false // データ取得が完了したらロード中状態を解除
                    }
                }
                .onDisappear {
                    if let handle = handle {
                        Auth.auth().removeStateDidChangeListener(handle)
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            
        }
    }
    
    private func sendVerificationCode() {
        PhoneAuthProvider.provider().verifyPhoneNumber(nationCode+inputNumber.removingFirstCharacter(), uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("エラー: \(error.localizedDescription)")
                return
            }
            sentCode = verificationID
            print("認証コードが送信されました")
            print(sentCode)
        }
    }
}

#Preview {
    RegisterPhoneNumberView()
}

struct PhoneGlobalCode: View {
    @Binding var nations: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Text("Select Your Country")
                    .font(
                        Font.custom("ModernEra-Medium", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.03, green: 0.03, blue: 0.03))
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image("Close button")
                        .frame(width: 11.8, height: 11.8)
                }
                .frame(alignment: .bottomTrailing)
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
            .padding(.trailing, 20)
            .padding(.leading, 20)
                
            ScrollView {
                ForEach(0..<allItems[0].count, id: \.self) { index in
                    Divider()
                    Button {
                        nations = allItems[0][index] + "+" + allItems[2][index]
                        dismiss()
                    }label: {
                        HStack(spacing: 0) {
                            ZStack {
                                Text(allItems[1][index]) // 国旗
                                    .font(
                                        Font.custom("ModernEra-Medium", size: 14)
                                            .weight(.medium)
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 28)
                                HStack {
                                    Text(allItems[0][index]) // 国コード
                                        .font(
                                            Font.custom("ModernEra-Medium", size: 14)
                                                .weight(.medium)
                                        )
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("+"+allItems[2][index]) // 国名
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(
                                    Font.custom("ModernEra-Medium", size: 14)
                                        .weight(.medium)
                                )
                        }
                        .padding(.vertical, 0)
                        .frame(width: 377)
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 15)
                }
            }
        }
        .padding(.horizontal, 15)
    }
}


extension String {
    mutating func removeFirstCharacter() {
        if !isEmpty {
            removeFirst()
        }
    }
    
    func removingFirstCharacter() -> String {
        var newString = self
        if !newString.isEmpty {
            newString.removeFirst()
        }
        return newString
    }
}
