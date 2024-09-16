//
//  signUpBro.swift
//  DTM
//
//

import SwiftUI
import Firebase
import FirebaseAuth
import UIKit

var broName = ""
var broProfile = UserProfile(name: broName)
var broRef = Firestore.firestore().collection("users").document(broProfile.name)

struct signUpBro: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var data: [String: Any]
    @Binding var withWho: String
    
    @State var inputEmail = ""
    @State private var isInput = false
    @FocusState private var focusNow:Bool
    
    @State private var alertItem: AlertItem? = nil
    @State private var isPresentingSheet = false
    
    @State private var isError = false
    
    var nowBro = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing:0) {
                    Spacer()
                    Button {
                        dismiss()
                    }label:{
                        Image("Close button")
                            .frame(width: 13.66246, height: 13.66246)
                            .padding(.top, 12)
                    }
                }
            }
            .padding(.horizontal, 18)
            
            // Line
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        ForEach(1...2, id:\.self) { number in
                            Spacer()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 140, height: 5)
                                .background(number <= nowBro ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color.clear)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    HStack {
                        ForEach(1...3, id:\.self) { number in
                            Image(systemName: number <= nowBro ? "circle.fill" : "circle")
                                .frame(width: 15, height: 15)
                                .background(Color.white)
                                .foregroundColor(number <= nowBro || number == 1 ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                            if number != 3 {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .frame(width: 329, height: 15)
            .padding(.top, 48)
            .padding(.horizontal, 48)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Add Friend")
                        .font(
                            Font.custom("Modern Era", size: 10.43161)
                                .weight(.medium)
                        )
                        .foregroundColor(nowBro == 0 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                    Spacer()
                    Text("Add Details")
                        .font(
                            Font.custom("Modern Era", size: 10.43161)
                                .weight(.medium)
                        )
                        .foregroundColor(nowBro == 1 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                        .padding(.trailing, 4)
                    Spacer()
                    Text("Confirm")
                        .font(
                            Font.custom("Modern Era", size: 10.43161)
                                .weight(.medium)
                        )
                        .foregroundColor(nowBro == 2 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                        .padding(.trailing, 5)
                }
            }
            .frame(width: 340, height: 15)
            
            VStack(spacing: 0) {
                Text("What’s Your McGill\nEmail?")
                    .font(
                        Font.custom("New York", size: 28)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: 319, height: 72, alignment: .topLeading)
                    .padding(.top, 103)
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
                
                // Next
                NavigationLink {
                    BroDetail(data: $data, withWho: $withWho)
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
                    broName = inputEmail
                    broProfile = UserProfile(name: broName)
                    broRef = Firestore.firestore().collection("users").document(broProfile.name)
                    saveUserProfile(userProfile: broProfile)
                    checkDocumentExists()
                    // sendSignInLink()
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 4)
                
            }
            .padding(.horizontal, 18)
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
    // signUpBro()
    // BroDetail()
    BroConfirm(data: Binding<[String: Any]>.constant(["Test2": ["Friday Aug 13th  8:0","🕺 Go to same club","35.0","139.0","Ramen Jiro", ""]]), withWho: Binding<String>.constant("Test2"))
}

struct BroDetail: View {
    @Binding var data: [String: Any]
    @Binding var withWho: String
    var nowBro = 1
    @State var year = ""
    @State var faculty = ""
    
    @State var showPicker1 = false
    
    @State var selectedImage1: UIImage?
    @State var selectedImage2: UIImage?
    @State var isPickerPresented1 = false
    @State var isPickerPresented2 = false
    @State private var showingImagePicker1 = false
    @State private var showingPhotoLibraryPicker1 = false
    @State private var showingImagePicker2 = false
    @State private var showingPhotoLibraryPicker2 = false
    
    var body: some View {
        // Line
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    ForEach(1...2, id:\.self) { number in
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 140, height: 5)
                            .background(number <= nowBro ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color.clear)
                            .cornerRadius(5)
                    }
                    Spacer()
                }
                HStack {
                    ForEach(1...3, id:\.self) { number in
                        Image(systemName: number <= nowBro ? "circle.fill" : "circle")
                            .frame(width: 15, height: 15)
                            .background(Color.white)
                            .foregroundColor(number <= nowBro || number == 1 ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                        if number != 3 {
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .frame(width: 329, height: 15)
        .padding(.top, 48)
        .padding(.horizontal, 48)
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Add Friend")
                    .font(
                        Font.custom("Modern Era", size: 10.43161)
                            .weight(.medium)
                    )
                    .foregroundColor(nowBro == 0 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                Spacer()
                Text("Add Details")
                    .font(
                        Font.custom("Modern Era", size: 10.43161)
                            .weight(.medium)
                    )
                    .foregroundColor(nowBro == 1 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                    .padding(.trailing, 4)
                Spacer()
                Text("Confirm")
                    .font(
                        Font.custom("Modern Era", size: 10.43161)
                            .weight(.medium)
                    )
                    .foregroundColor(nowBro == 2 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                    .padding(.trailing, 5)
            }
        }
        .frame(width: 340, height: 15)
        
        VStack(spacing: 0) {
            Text("edward.granville@mail.mcgill.ca doesn’t have a profile. No stress! Add their details here:")
                .font(
                    Font.custom("SF Pro", size: 14)
                        .weight(.bold)
                        .italic()
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 329, alignment: .top)
                .padding(.top, 48)
            HStack(spacing: 0) {
                Text("Their Year?")
                    .font(
                        Font.custom("New York", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(height: 16, alignment: .top)
                    .padding(.top, 48)
                Spacer()
            }
            HStack(spacing: 0) {
                HStack {
                    ForEach(years, id: \.self) {ye in
                        optionYear(title: ye, year: $year)
                        if ye != years.last {
                            Text("")
                        }
                    }
                }
                .padding(.top, 24)
                Spacer()
            }
            
            HStack(spacing: 0) {
                Text("Their Faculty?")
                    .font(
                        Font.custom("New York", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(height: 14, alignment: .top)
                    .padding(.top, 48)
                Spacer()
            }
            VStack {
                HStack {
                    Text(faculty.isEmpty ? "Select your Answer" : faculty)
                        .foregroundColor(.black)
                        .opacity(faculty.isEmpty ? 0.2 : 1)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(Color.white)
                .cornerRadius(8)
                .onTapGesture {
                    showPicker1.toggle()
                }
                
                Rectangle()
                    .padding(.top, 0)
                    .background(.black)
                    .frame(height: 1)
            }
            .padding(.top, 23)
            
            if showPicker1 {
                List(faculties, id: \.self) { option in
                    Button(action: {
                        faculty = option
                        showPicker1 = false
                    }) {
                        Text(option)
                            .foregroundColor(.black)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                // .frame(maxHeight: 1000)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            } else {
                HStack(spacing: 0) {
                    Text("Two Photos of Them")
                        .font(
                            Font.custom("New York", size: 20)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(height: 14)
                        .padding(.top, 48)
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    // 1
                    ZStack {
                        if let image1 = selectedImage1 {
                            Image(uiImage: image1)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 81)
                                .cornerRadius(10)
                        } else {
                            Image("add-pic")
                                .resizable()
                                .padding(.leading, 6)
                                .foregroundColor(.clear)
                                .frame(width: 80, height: 72)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 4.5)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            isPickerPresented1.toggle()
                        }) {
                            Rectangle()
                                .foregroundColor(.white.opacity(0))
                                .frame(width: 90, height: 81)
                                .cornerRadius(8)
                        }
                        .actionSheet(isPresented: $isPickerPresented1) {
                            ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                .default(Text("カメラ")) {
                                    showingImagePicker1 = true
                                },
                                .default(Text("フォトライブラリ")) {
                                    showingPhotoLibraryPicker1 = true
                                },
                                .cancel()
                            ])
                        }
                        .sheet(isPresented: $showingImagePicker1) {
                            ImagePicker(image: $selectedImage1, sourceType: .camera)
                        }
                        .sheet(isPresented: $showingPhotoLibraryPicker1) {
                            PhotoLibraryPicker(image: $selectedImage1)
                        }
                    }
                    .padding(.trailing, 24)
                    // 2
                    ZStack {
                        if let image2 = selectedImage2 {
                            Image(uiImage: image2)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 81)
                                .cornerRadius(10)
                        } else {
                            Image("add-pic")
                                .resizable()
                                .padding(.leading, 6)
                                .foregroundColor(.clear)
                                .frame(width: 80, height: 72)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 4.5)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            isPickerPresented2.toggle()
                        }) {
                            Rectangle()
                                .foregroundColor(.white.opacity(0))
                                .frame(width: 90, height: 81)
                                .cornerRadius(8)
                        }
                        .actionSheet(isPresented: $isPickerPresented2) {
                            ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                .default(Text("カメラ")) {
                                    if selectedImage1 == nil {
                                        showingImagePicker1 = true
                                    } else {
                                        showingImagePicker2 = true
                                    }
                                },
                                .default(Text("フォトライブラリ")) {
                                    if selectedImage1 == nil {
                                        showingPhotoLibraryPicker1 = true
                                    } else {
                                        showingPhotoLibraryPicker2 = true
                                    }
                                },
                                .cancel()
                            ])
                        }
                        .sheet(isPresented: $showingImagePicker2) {
                            ImagePicker(image: $selectedImage2, sourceType: .camera)
                        }
                        .sheet(isPresented: $showingPhotoLibraryPicker2) {
                            PhotoLibraryPicker(image: $selectedImage2)
                        }
                    }
                }
                .padding(.top, 24)
            }
            
            // Next
            NavigationLink {
                BroConfirm(data: $data, withWho: $withWho)
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
                    .background(year.isEmpty || faculty.isEmpty || selectedImage1 == nil ? AnyView(Constants.PlaceholderGrey) : AnyView(LinearGradient(
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
            .disabled(year.isEmpty || faculty.isEmpty || selectedImage1 == nil)
            .frame(width: 85, height: 52, alignment: .trailing)
            .simultaneousGesture(TapGesture().onEnded {
                // 実行させたい処理を記載
                updateProfileBro(segment: "year", value: year)
                updateProfileBro(segment: "faculty", value: faculty)
                if let image1 = selectedImage1 {
                    uploadImage(image: image1, name: broName, number: "1") { url in
                        if let url = url {
                            // saveImageUrlToFirestore(url: url)
                            updateProfileBro(segment: "profileImageURL1", value: url.absoluteString)
                        }
                    }
                }
                if let image2 = selectedImage2 {
                    uploadImage(image: image2, name: broName, number: "2") { url in
                        if let url = url {
                            // saveImageUrlToFirestore(url: url)
                            updateProfileBro(segment: "profileImageURL2", value: url.absoluteString)
                        }
                    }
                }
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 48)
            .padding(.bottom, 4)
        }
        .padding(.horizontal, 32)
        
        Spacer()
    }
}

struct BroConfirm: View {
    @Binding var data: [String: Any]
    @Binding var withWho: String
    var nowBro = 2
    @State private var isChecked: Bool = false
    @State var isComp = false
    var body: some View {
            // Line
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        ForEach(1...2, id:\.self) { number in
                            Spacer()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 140, height: 5)
                                .background(number <= nowBro ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color.clear)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    HStack {
                        ForEach(1...3, id:\.self) { number in
                            Image(systemName: number <= nowBro ? "circle.fill" : "circle")
                                .frame(width: 15, height: 15)
                                .background(Color.white)
                                .foregroundColor(number <= nowBro || number == 1 ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                            if number != 3 {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .frame(width: 329, height: 15)
            .padding(.top, 48)
            .padding(.horizontal, 48)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Add Friend")
                        .font(
                            Font.custom("Modern Era", size: 10.43161)
                                .weight(.medium)
                        )
                        .foregroundColor(nowBro == 0 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                    Spacer()
                    Text("Add Details")
                        .font(
                            Font.custom("Modern Era", size: 10.43161)
                                .weight(.medium)
                        )
                        .foregroundColor(nowBro == 1 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                        .padding(.trailing, 4)
                    Spacer()
                    Text("Confirm")
                        .font(
                            Font.custom("Modern Era", size: 10.43161)
                                .weight(.medium)
                        )
                        .foregroundColor(nowBro == 2 ? Color(red: 0.89, green: 0.17, blue: 0.3) : .black)
                        .padding(.trailing, 5)
                }
            }
            .frame(width: 340, height: 15)
            
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("How it works")
                    .font(
                        Font.custom("New York", size: 24)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.03, green: 0.03, blue: 0.03))
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("1")
                            .font(
                                Font.custom("SF Pro", size: 12)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                    }
                    .padding(6)
                    .frame(width: 20, height: 20, alignment: .center)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.13, green: 0.83, blue: 0.61), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.13, green: 0.85, blue: 0.62), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.1, green: 0.76, blue: 0.45), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .cornerRadius(10)
                    
                    Text("Confirm below, then ensure your friend clicks the confirmation link sent to their email")
                        .font(Font.custom("SF Pro", size: 14))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 48)
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("2")
                            .font(
                                Font.custom("SF Pro", size: 12)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                    }
                    .padding(6)
                    .frame(width: 20, height: 20, alignment: .center)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.13, green: 0.83, blue: 0.61), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.13, green: 0.85, blue: 0.62), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.1, green: 0.76, blue: 0.45), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .cornerRadius(10)
                    
                    Text("We’ll then match you with another duo")
                        .font(Font.custom("SF Pro", size: 14))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 48)
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("3")
                            .font(
                                Font.custom("SF Pro", size: 12)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                    }
                    .padding(6)
                    .frame(width: 20, height: 20, alignment: .center)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.13, green: 0.83, blue: 0.61), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.13, green: 0.85, blue: 0.62), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.1, green: 0.76, blue: 0.45), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .cornerRadius(10)
                    
                    Text("12th September 9:00pm: Meet your double dates at the bar. There’ll be drinks, music & 170 McGill students (you’ll have your own table)")
                        .font(
                            Font.custom("SF Pro", size: 14)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 48)
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("4")
                            .font(
                                Font.custom("SF Pro", size: 12)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                    }
                    .padding(6)
                    .frame(width: 20, height: 20, alignment: .center)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.13, green: 0.83, blue: 0.61), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.13, green: 0.85, blue: 0.62), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.1, green: 0.76, blue: 0.45), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .cornerRadius(10)
                    
                    Text("10:30pm: Head to the club, Barbossa, with the dates ")
                        .font(
                            Font.custom("SF Pro", size: 14)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 48)
                
                HStack(alignment: .top,  spacing: 0) {
                    Toggle(isOn: $isChecked) {}
                    .toggleStyle(CheckboxStyle())
                    
                    Text("I understand, If I confirm & don’t show, I will be permanently blocked from the app")
                        .font(Font.custom("SF Pro", size: 14))
                        .foregroundColor(.black)
                        .frame(width: 290, height: 36, alignment: .topLeading)
                        .padding(.leading, 10)
                }
                .padding(.top, 84)
                
                Button {
                    setDouble(to: userName, from: withWho, state: broName)
                    isComp = true
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        // Small text
                        Text("Confirm Sign Up ")
                            .font(
                                Font.custom("ModernEra-Medium", size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 125, alignment: .top)
                    }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .frame(width: 161, height: 40, alignment: .center)
                        .background(isChecked ?
                            AnyView (LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                    Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )) : AnyView (Constants.disableGrey)
                        )
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 4)
                        .padding(.top, 48)
                }
                .fullScreenCover(isPresented: $isComp) {
                    TopMainTab(selection: Binding<Int>.constant(1))
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .padding(.top, 30)
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // チェックボックスの外観と動作を返す
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" :
                    "square")
            .foregroundColor(configuration.isOn ? .blue : .black)
            .font(.system(size: 28, weight: .semibold, design: .rounded))
            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
