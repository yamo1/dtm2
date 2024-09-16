
#Preview {
    RegisterPhoneCodeView()
}

import UIKit
import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterPhoneCodeView: View {
    enum FocusPin: Int {
        case pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
    }
    
    @FocusState private var pinFocusState: FocusPin?
    
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""
    
    @State private var isPresentingSheet = false
    
    var now = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var fetchedNumber: String? = nil
    
    @State private var timeRemaining = 20
    @State private var timerIsRunning = false
    
    @State private var tmp = false
    
    func startTimer() {
        timerIsRunning = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
                self.timerIsRunning = false
                tmp = false
                timeRemaining = 20
            }
        }
    }
    
    var body: some View {
        VStack {
            
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
            .task {
                Task {
                    do {
                        try await fetchData(value: userName, what: "number", number: $fetchedNumber)
                    } catch {
                        print("error occur")
                    }
                }
            }
            
            // Number
            VStack(spacing: 0) {
                // What's Your McGill Email?
                Text("Enter Your Code")
                    .font(
                        Font.custom("New York", size: 24)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 0){
                    // info
                    Text("\(fetchedNumber ?? "No data")")
                        .font(
                            Font.custom("ModernEra-Medium", size: 12)
                                .weight(.medium)
                        )
                        .foregroundColor(.gray)
                    
                    ZStack {
                        if tmp {
                            Text("\(timeRemaining)")
                                .font(
                                    Font.custom("Plus Jakarta Sans", size: 12)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 1, green: 0.75, blue: 0.03))
                        }
                        Button {
                            // sendVerificationCode()
                            startTimer()
                            tmp = true
                        } label: {
                            if tmp == false {
                                Text("Resend")
                                    .font(
                                        Font.custom("ModernEra-Medium", size: 12)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .frame(height: 20)
                    .padding(.leading, 8)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                
                // inputForm
                HStack(alignment: .center, spacing: 15) {
                    ForEach(0..<6) { index in
                        VStack {
                            CustomTextFieldRepresentable(text: self.binding(for: index), tag: index, onDeleteBackward: {
                                self.focusPreviousField(currentIndex: index)
                            }, onCommit: {
                                
                            })
                            .frame(width: 30, height: 30)
                            .onChange(of: self.binding(for: index).wrappedValue) { newVal in
                                if newVal.count == 1 {
                                    if index == 5 {
                                        self.performNextAction()
                                    }
                                    self.focusNextField(currentIndex: index)
                                }
                            }
                            .focused($pinFocusState, equals: FocusPin(rawValue: index))
                            .onAppear() {
                                if (index == 0) {
                                    DispatchQueue.main.async {
                                        pinFocusState = .pinOne
                                    }
                                }
                            }
                            
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(height: 1)
                        }
                    }
                }
                .padding(.top, 72)
                .frame(width: 260)
                
                Spacer()
                
                // Next
                NavigationLink(destination:RegisterC1(), isActive: $isPresentingSheet) {
                    EmptyView()
                }
                
                NavigationLink {
                    RegisterC1()
                } label: {
                    Text("仮")
                        .font(
                            Font.custom("ModernEra-medium", size: 16)
                        )
                        .bold()
                        .padding()
                        .frame(width: 110, height: 45)
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.89, green: 0.17, blue: 0.3))
                        .cornerRadius(27)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            pinFocusState = nil
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: HStack {
            // Backボタンはデフォルトで表示されるので特に追加しない
            CustomBackButton()
        })
    }
    
    private func binding(for index: Int) -> Binding<String> {
        switch index {
        case 0: return $pinOne
        case 1: return $pinTwo
        case 2: return $pinThree
        case 3: return $pinFour
        case 4: return $pinFive
        case 5: return $pinSix
        default: return $pinOne
        }
    }
    
    private func focusNextField(currentIndex: Int) {
        if currentIndex < 5 {
            pinFocusState = FocusPin(rawValue: currentIndex + 1)
        }
    }
    
    private func focusPreviousField(currentIndex: Int) {
        if currentIndex > 0 {
            pinFocusState = FocusPin(rawValue: currentIndex - 1)
        }
    }
    
    private func performNextAction() {
        // 次の操作をここに実装
        print("６桁入力完了")
        verifyCode()
    }
    
    private func verifyCode() {
        guard let verificationID = sentCode else {
            print("まず認証コードを送信してください")
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: pinOne+pinTwo+pinThree+pinFour+pinFive+pinSix
        )
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("エラー: \(error.localizedDescription)")
                return
            }
            print("ログイン成功")
            isPresentingSheet = true
        }
    }
}
