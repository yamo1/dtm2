//
//  RegisterC1_2.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/07.
//

import SwiftUI

let heights = [
    ["4.9", "149"], ["5.0", "152"], ["5.1", "155"], ["5.2", "158"], ["5.3", "162"], ["5.4", "165"],
    ["5.5", "168"], ["5.6", "171"], ["5.7", "174"], ["5.8", "177"], ["5.9", "180"], ["6.0", "183"],
    ["6.1", "186"], ["6.2", "189"], ["6.3", "192"], ["6.4", "195"], ["6.5", "198"], ["6.6", "201"],
    ["6.7", "204"], ["6.8", "207"], ["6.9", "210"], ["7.0", "213"], ["7.1", "216"], ["7.2", "219"],
    ["7.3", "223"], ["7.4", "226"], ["7.5", "229"]
]


struct RegisterC1_2: View {
    @State var height = ""
    
    var now = 3
    
    @State private var isButton = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                RegisterC2()
            } label: {
                Text("Complete later")
                    .font(
                        Font.custom("ModernEra-Medium", size: 12)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 32)
                    .padding(.top, 16)
            }
            
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
            
            // Height
            VStack(spacing: 0) {
                Text("My Height")
                    .font(
                        Font.custom("New York", size: 28)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(height: 20, alignment: .leading)
                    .padding(.top, 60)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 26)
            .padding(.trailing, 26)
            
            // HeightView
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(heights, id: \.self) { num in
                            Button {
                                isButton = true
                                height = num[1]
                            }label: {
                                VStack(spacing: 0) {
                                    if num[1] == height {
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color(red: 0.89, green: 0.17, blue: 0.3))
                                    }
                                    Text("\(num[0])ft    (\(num[1]) cm)")
                                        .font(
                                            Font.custom("ModernEra-Medium", size: 24)
                                                .weight(.medium)
                                        )
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(num[1] == height ? Color.black : Color.black.opacity(0.2))
                                        .padding(.vertical, 12)
                                        //.background(num[1] == height ? Color.gray.opacity(0.1) : Color.clear)
                                    if num[1] == height {
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color(red: 0.89, green: 0.17, blue: 0.3))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.all, 0)
            }
            .frame(height: 207)
            .padding(.top, 72)
            .padding(.leading, 36)
            .padding(.trailing, 36)
            
            // Next
            NavigationLink {
                RegisterC2()
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
                    .cornerRadius(33)
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .simultaneousGesture(TapGesture().onEnded {
                // 実行させたい処理を記載
                updateProfile(segment: "height", value: height)
            })
            .padding(.top, 84)
            .padding(.leading, 26)
            .padding(.trailing, 26)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
        Spacer()
    }
}

#Preview {
    RegisterC1_2()
}
