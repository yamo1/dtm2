//
//  RegisterC6_2.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/23.
//

import SwiftUI

struct RegisterC6_2: View {
    @State var inputReason2 = ""
    @State private var isInput = false
    @State var reason2 = ""
    
    var now = 9
    public var body: some View {
        VStack {
            NavigationLink {
                RegisterC6_3()
                
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
            
            // Number
            VStack(alignment: .leading) {
                // Title
                Text("Prompt 2")
                    .font(
                        Font.custom("New York", size: 28)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(height: 20, alignment: .topLeading)
                    .padding(.bottom, 20)
                
                // info
                CustomPicker(selectedValue: $reason2, options: reasons)
                    .frame(maxWidth: .infinity)
                    .font(
                        Font.custom("Modern Era", size: 12)
                            .weight(.medium)
                    )
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                
                
                // inputForm
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        CustomTextView(text: $inputReason2, placeholder: "Type response here")
                            .frame(height: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.1)
                )
                
                Spacer()
                
                // Next
                NavigationLink {
                    RegisterC6_3()
                } label: {
                    Text("Next")
                        .font(
                            Font.custom("ModernEra-Medium", size: 16)
                        )
                        .bold()
                        .frame(width: 54, height: 22)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.89, green: 0.17, blue: 0.3))
                        .cornerRadius(33)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .simultaneousGesture(TapGesture().onEnded {
                    // 実行させたい処理を記載
                    updateProfile(segment: "prompt2Select", value: reason2)
                    updateProfile(segment: "prompt2", value: inputReason2)
                })
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterC6_2()
}
