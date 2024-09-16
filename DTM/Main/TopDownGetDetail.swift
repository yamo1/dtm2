//
//  TopDownGetDetail.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/28.
//

import SwiftUI

struct TopDownGetDetail: View {
    @Binding var showDetailView: Bool
    var namespace: Namespace.ID
    @State private var currentIndex = 1
    @State private var isConfirm = false
    @Binding var isMatch: Bool
    @Binding var from: String
    
    @Binding var matchData: [String]
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            showDetailView = false
                        }
                    } label: {
                        HStack(spacing: 0){
                            Image(systemName: "chevron.left")
                                .font(
                                    Font.custom("SF Pro", size: 17)
                                        .weight(.bold)
                                )
                                .frame(width: 17, height: 12)
                            Text("Back")
                                .font(Font.custom("SF Pro", size: 17))
                        }
                        .foregroundColor(Constants.InfoGrey)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                    .padding(.top, 46)
                    
                    Text("Name")
                        .font(
                            Font.custom("Modern Era", size: 24)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .padding(.top, 52)
                }
                .ignoresSafeArea(.all)
                
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            Image("testImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: "Pic", in: namespace)
                                .frame(width: 360, height: 360)
                                .clipped()
                        )
                        .cornerRadius(10)
                        .frame(width: 360, height: 360)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        .padding(.top, 16)
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(1...6, id: \.self) { index in
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(
                                        Image("testImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 75, height: 72)
                                            .clipped()
                                    )
                                    .cornerRadius(20)
                                    .frame(width: 75, height: 72)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    .padding(.trailing, index == 6 ? 0 : 30)
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                ZStack {
                    VStack(spacing: 0) {
                        if currentIndex == 1 {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text("About")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                        .frame(alignment: .topLeading)
                                        .padding(.top, 16)
                                    Spacer()
                                }
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("U3")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.black)
                                        .frame(alignment: .leading)
                                    Spacer()
                                    Text("Faculty of Arts")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                        .frame(alignment: .topLeading)
                                    Spacer()
                                    Text("London")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.ContentBlack)
                                        .frame(alignment: .leading)
                                }
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("📏 193cm")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.ContentBlack)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                        .cornerRadius(10)
                                    Spacer()
                                    Text("🎉 1 - 2 a week")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.ContentBlack)
                                        .frame(alignment: .leading)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                        .cornerRadius(10)
                                    Spacer()
                                    Text("🏉 Philosophy")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.ContentBlack)
                                        .frame(alignment: .leading)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                        .cornerRadius(10)
                                }
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("🎧 Electronica, Techno")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.ContentBlack)
                                        .frame(alignment: .leading)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                        .cornerRadius(10)
                                    Spacer()
                                    
                                    Text("🎹 Music Production")
                                        .font(
                                            Font.custom("Modern Era", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.ContentBlack)
                                        .frame(alignment: .leading)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                        .cornerRadius(10)
                                }
                                Spacer()
                                HStack(spacing: 0) {
                                    Text("Prompt 1")
                                        .frame(width: 56, alignment: .leading)
                                    Image(systemName: "chevron.down")
                                }
                                .font(Font.custom("Modern Era", size: 14))
                                .foregroundColor(Constants.InfoGrey)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        } else if currentIndex == 2 {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text("You’ll just need to meet me, to find out about ")
                                        .font(
                                            Font.custom("Modern Era", size: 14)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                        .frame(width: 267, alignment: .topLeading)
                                        .padding(.top, 24)
                                    Spacer()
                                }
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscind")
                                    .font(
                                        Font.custom("Test Tiempos Headline", size: 24)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .frame(width: 358, height: 53, alignment: .top)
                                    .padding(.top, 36)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            
                        } else if currentIndex == 3 {
                            
                        } else if currentIndex == 4 {
                            
                        }
                    }
                    .frame(width: 393, height: 261)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .inset(by: 0.5)
                            .stroke(Constants.PlaceholderGrey, lineWidth: Constants.StrokeBorder)
                    )
                    .padding(.top, 12)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.height < 0 {
                                    withAnimation {
                                        currentIndex = (currentIndex + 1)
                                    }
                                } else if value.translation.height > 0 {
                                    withAnimation {
                                        currentIndex = (currentIndex - 1)
                                    }
                                }
                            }
                    )
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                            Button {
                                // meetUpButton
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                                    isConfirm = true
                                }
                            }label: {
                                VStack(alignment: .center, spacing: 10) {
                                    Image("Loveheart_white")
                                        .frame(width: 27, height: 23.37073)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 18)
                                .frame(width: 60, alignment: .center)
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
                                .cornerRadius(1000)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            }
                        }
                        .padding(.trailing, 26)
                        Spacer()
                    }
                }
            }
            if isConfirm {
                PopupConfirmView(isPresented: $isConfirm, matchData: $matchData, isMatch: $isMatch, from: $from)
            }
        }
    }
}


struct ContentView_Previews2: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        Group {
            TopDownGetDetail(showDetailView: Binding<Bool>.constant(true), namespace: namespace, isMatch: Binding<Bool>.constant(true), from: Binding<String>.constant(""), matchData: Binding<[String]>.constant(["","","","","",""]))
        }
    }
}

struct PopupConfirmView: View {
    @Binding var isPresented: Bool
    @Binding var matchData: [String]
    @Binding var isMatch: Bool
    @Binding var from: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                PopupBackgroundView(isPresented: isPresented)
                    .transition(.opacity)
                PopupContents2View(isPresented: $isPresented, isMatch: $isMatch, matchData: $matchData, from: $from)
                    .frame(width: 361, height: 181)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .inset(by: 0.5)
                            .stroke(Constants.PlaceholderGrey, lineWidth: Constants.StrokeBorder)
                    )
            }
        }
    }
}

struct PopupContents2View: View {
    @Binding var isPresented: Bool
    @Binding var isMatch: Bool
    @State private var isInfo = false
    @Binding var matchData: [String]
    @Binding var from: String
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ZStack {
                    Text("Meet \(from)")
                        .font(
                            Font.custom("PT Serif", size: 18)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 109, height: 13, alignment: .top)
                    
                    HStack(spacing: 0) {
                        Spacer()
                        Button {
                            isPresented = false
                        } label: {
                            Text("Cancel")
                                .font(Font.custom("SF Pro", size: 15))
                                .foregroundColor(Constants.InfoGrey)
                        }
                        .padding(.trailing, 24)
                    }
                }
            }
            .padding(.top, 12)
            
            Text(matchData[0]+" at "+matchData[4])
                .font(
                    Font.custom("Modern Era", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 24)
            HStack(spacing: 0) {
                Text(matchData[1])
                    .font(
                        Font.custom("Modern Era", size: 16)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                Button {
                    isInfo = true
                } label:{
                    Image(systemName: "info.circle")
                }
                .sheet(isPresented: $isInfo) {
                    infoView121()
                }
                .padding(.leading, 8)
            }
            
            Button {
                // Confirm
                Task {
                    do {
                        let fromT = String(from.dropFirst(4))
                        try await confirmMatch(one:userName, two:fromT, detail: $matchData)
                    } catch {
                        print("Failed to fetch data: \(error)")
                    }
                }
                // Decline
                matchDelete(to: userName) { success in
                    if success {
                        print("処理が完了しました。")
                        // 他の処理をここで実行
                        isMatch = false
                    } else {
                        print("処理中にエラーが発生しました。")
                        // エラーハンドリング
                    }
                }
                isPresented = false
            }label:{
                HStack(alignment: .center, spacing: 8) {
                    Text("Confirm and Accept")
                        .font(
                            Font.custom("Modern Era", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(Constants.GraysWhite)
                }
                    .padding(12)
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
                    .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 2)
            }
            .padding(.top, 36)
            Spacer()
        }
    }
}


struct infoView121: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                       // close
                        dismiss()
                    } label: {
                        Image("Close button")
                            .frame(width: 11.17838, height: 11.17838)
                    }
                    .ignoresSafeArea()
                    .padding(.top, 24)
                    .padding(.trailing, 24)
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 350, height: 217.24513)
                    .background(
                        Image("howsPage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 350, height: 217.24513244628906)
                            .clipped()
                    )
                    .padding(.top, 48)
                Text("1-2-1 meets")
                    .font(
                        Font.custom("TT Norms Pro Serif", size: 24)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.03, green: 0.03, blue: 0.03))
                    .padding(.top, 36)
                Text("1) You have 18 hours to accept the invite")
                    .font(
                        Font.custom("Modern Era", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.46, green: 0.47, blue: 0.47))
                    .frame(width: 325, alignment: .leading)
                    .padding(.top, 36)
                Text("2) If you accept, 5 minutes before you can text to find each other")
                    .font(
                        Font.custom("Modern Era", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.46, green: 0.47, blue: 0.47))
                    .frame(width: 318, alignment: .leading)
                    .padding(.top, 36)
                Text("3) Go and enjoy meeting in person, rather than over text!")
                    .font(
                        Font.custom("Modern Era", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.46, green: 0.47, blue: 0.47))
                    .frame(width: 318, alignment: .leading)
                    .padding(.top, 36)
                Text("How do I know they’ll show? ")
                    .font(
                        Font.custom("Modern Era", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.13, green: 0.83, blue: 0.61))
                    .frame(width: 185, alignment: .leading)
                    .padding(.top, 60)
                
                Spacer()
            }
            VStack(spacing: 0) {
                Spacer()
                Button {
                    dismiss()
                } label:{
                    VStack(alignment: .center, spacing: 19) {
                        Text("Nice, Got it ")
                            .font(
                                Font.custom("Modern Era", size: 20)
                                    .weight(.bold)
                            )
                            .foregroundColor(Constants.GraysWhite)
                    }
                    .padding(.horizontal, 0)
                    .padding(.bottom, 0)
                    .frame(width: 393, height: 64, alignment: .bottom)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.13, green: 0.83, blue: 0.61).opacity(0.6), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.13, green: 0.85, blue: 0.62).opacity(0.6), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.1, green: 0.76, blue: 0.45).opacity(0.6), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                }
            }
        }
    }
}
