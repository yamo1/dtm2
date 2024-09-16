//
//  serarchProfile.swift
//  DTM
//
//  Created by 水野裕介 on 2024/08/04.
//

import SwiftUI

struct serarchProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var inputName = ""
    @State private var selectName = ""
    
    @State private var tmp = ""
    
    @State private var isDisplay = false
    @State private var docName = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing:0) {
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
                
                HStack(spacing: 0) {
                    Text("Meet Someone Specific")
                        .font(
                            Font.custom("Modern Era", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 310, alignment: .center)
                        .padding(.top, 46)
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    Text("What’s their name?")
                        .font(
                            Font.custom("Modern Era", size: 18)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                        .frame(width: 158, height: 12, alignment: .center)
                        .padding(.top, 84)
                    
                    Spacer()
                }
                
                
                ZStack {
                    HStack(spacing: 0) {
                        Button {
                            selectName = inputName
                            searchUser(name: selectName) { judge, name in
                                isDisplay = judge
                                docName = name
                            }
                        }label:{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                                .padding(.trailing, 5)
                                .padding(.leading, 20)
                        }
                        TextField(" Firstname Lastname", text: $inputName)
                            .font(Font.custom("Modern Era", size: 20))
                    }
                }
                    .frame(width: 317, height: 48)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 1.5)
                            .stroke(Color(red: 0.99, green: 0.94, blue: 0.95), lineWidth: 3)
                    )
                    .padding(.top, 48)
                
                if isDisplay {
                    NavigationLink {
                        searchDetailView(name: $docName)
                    } label: {
                        ZStack {
                            HStack(spacing: 0) {
                                Text(" \(docName)")
                                    .font(
                                        Font.custom("Modern Era", size: 16)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .padding(.leading, 42)
                                    .padding(.trailing, 14)
                                Image("check")
                                    .frame(width: 15, height: 15)
                                Spacer()
                            }
                        }
                            .frame(width: 317, height: 48)
                            .background(Color(red: 0.97, green: 0.98, blue: 1))
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: Constants.StrokeBorder)
                            )
                            .padding(.top, 8)
                    }
                }
                
                
                HStack(spacing: 0) {
                    Button {
                        
                    } label:{
                        Text("Don’t know their last name?")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                            .frame(width: 179, alignment: .topLeading)
                    }
                    
                    Spacer()
                }
                .padding(.top, 28)
                
                Spacer()
            }
            .padding(.horizontal, 36)
            
            HStack(spacing:0) {
                Spacer()
                Button (action: {
                    selectName = inputName
                    searchUser(name: selectName) { judge, name in
                        isDisplay = judge
                        docName = name
                    }
                }) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("Go")
                            .font(
                                Font.custom("Modern Era", size: 20)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.GraysWhite)
                            .frame(width: 28, alignment: .top)
                    }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 0)
                        .frame(width: 64, height: 57, alignment: .center)
                        .background(
                            inputName.isEmpty ?
                            AnyView(Color(red: 0.93, green: 0.93, blue: 0.93)) :
                                AnyView(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                        Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                ))
                        )
                        .cornerRadius(3100)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                }
                .disabled(inputName.isEmpty)
            }
            .padding(.trailing, 18)
            
            Spacer()
        }
    }
}

#Preview {
    serarchProfileView()
}

struct searchDetailView: View {
    @Binding var name: String
    @State var dataName = ""
    @State var URL: String?
    @State var img: UIImage?
    @State var isFirstPresented = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(name.split(separator: " ")[0])
                        .font(
                            Font.custom("Modern Era", size: 24)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .frame(width: 73, height: 9, alignment: .topLeading)
                }
                    .frame(width: 135, height: 17)
                    .padding(.top, 45)
                
                ZStack {
                    if let img = img {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 450)
                            .clipped()
                    }
                }
                .frame(width: 300, height: 299.16898)
                .background(Constants.GraysWhite)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 4)
                .padding(.top, 48)
                
                Button {
                    isFirstPresented = true
                } label: {
                    HStack(alignment: .center, spacing: 9.75129) {
                        Text("Meet Up")
                            .font(
                                Font.custom("Modern Era", size: 17.55232)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.GraysWhite)
                    }
                        .padding(.horizontal, 38.03003)
                        .padding(.vertical, 16.57719)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                    Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                        .cornerRadius(14.62693)
                        .shadow(color: .black.opacity(0.15), radius: 0, x: 0, y: 3.90052)
                        .padding(.top, 48)
                }
                
                Text("Send Arthur an invite to meet")
                    .font(
                        Font.custom("Modern Era", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 274, alignment: .top)
                    .padding(.top, 48)
                
                Text("(You cannot view their profile in search)")
                    .font(
                        Font.custom("Modern Era", size: 14)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 252, alignment: .top)
                    .padding(.top, 24)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)  // 標準の戻るボタンを隠す
            .navigationBarItems(leading: CustomBackButton2()) // カスタム戻るボタンを設定
            .task {
                Task {
                    do {
                        print("here")
                        let tmpName = name.split(separator: " ")
                        dataName = tmpName[0]+"."+tmpName[1]
                        dataName = "Test1"
                        try await fetchData(value: dataName, what: "profileImageURL1", number: $URL)
                        print(URL)
                        print(dataName)
                        if let url = URL {
                            print("get url")
                            loadImage(urlString: url) { image in
                                if let image = image {
                                    print("get img")
                                    img = image
                                }
                            }
                        }
                    } catch {
                        print("catch error when fetch url")
                    }
                }
            }
            
            if isFirstPresented {
                @State var t = 0
                PopupView(isPresented: $isFirstPresented, index: $t)
            }
        }
    }
}
